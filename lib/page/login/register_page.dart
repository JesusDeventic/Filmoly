import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/controller/recaptcha_controller.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/user_model.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:filmoly/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    RecaptchaService.showBadge();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _submitRegister() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    final isNotBot = await RecaptchaService.isNotABot();
    if (!isNotBot) {
      showCustomSnackBar(S.current.error, type: -1);
      return;
    }
    setState(() => _isLoading = true);
    try {
      final result = await FilmolyApi.register(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
      );
      if (!mounted) return;
      if (result['success'] == true && result['token'] != null) {
        final token = result['token'] as String;
        final userJson = result['user'] as Map<String, dynamic>?;
        if (userJson != null) {
          await FilmolyApi.saveToken(token);
          globalCurrentUser = FilmolyUser.fromJson(userJson);
          showCustomSnackBar(S.current.welcome, type: 1);
          RecaptchaService.hideBadge();
          context.go(AppRoutes.home);
          return;
        }
      }
      final message = result['message'] as String? ?? S.current.registerError;
      showCustomSnackBar(message, type: -1);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios de idioma para reconstruir toda la pantalla de registro
    Provider.of<LanguageProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: unFocusGlobal,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: screenWidth > 500 ? 500 : screenWidth,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      rowSettingsAppAndVersion(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildLogo(context),
                            const SizedBox(height: 24),
                            TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: S.current.username,
                            prefixIcon: const Icon(Icons.person_outline),
                            border: const OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_\-.]')),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v.length < 3) return S.current.usernameMinLength;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: S.current.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (!v.contains('@') || !v.contains('.')) return S.current.invalidEmail;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo de nombre para mostrar (opcional) oculto de momento.
                        // TextFormField(
                        //   controller: _displayNameController,
                        //   decoration: InputDecoration(
                        //     labelText: S.current.displayName,
                        //     prefixIcon: const Icon(Icons.badge_outlined),
                        //     border: const OutlineInputBorder(),
                        //   ),
                        //   textInputAction: TextInputAction.next,
                        // ),
                        // const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: S.current.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v.length < 8) return S.current.passwordMinLength;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: S.current.confirmPassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submitRegister(),
                          validator: (v) {
                            if (v == null || v.isEmpty) return S.current.fieldRequired;
                            if (v != _passwordController.text) return S.current.passwordMismatch;
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitRegister,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(S.current.signUp),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => context.go(AppRoutes.login),
                            child: Text(S.current.signIn),
                          ),
                        ),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      width: 160,
      errorBuilder: (_, __, ___) => Text(
        S.current.appName,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
