import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/model/user_model.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _keepSession = true;
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    setState(() => _isLoading = true);
    try {
      final result = await FilmolyApi.login(
        login: _loginController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        final token = result['token'] as String?;
        final userJson = result['user'] as Map<String, dynamic>?;
        if (token != null && userJson != null) {
          await FilmolyApi.saveToken(token);
          globalCurrentUser = FilmolyUser.fromJson(userJson);
          if (_keepSession) {
            // Token ya guardado en saveToken
          }
          showCustomSnackBar(S.current.welcome, type: 1);
          context.go(AppRoutes.home);
          return;
        }
      }
      final message = result['message'] as String? ?? 'Credenciales incorrectas';
      showCustomSnackBar(message, type: -1);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildLogo(context),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _loginController,
                              decoration: InputDecoration(
                                labelText: S.current.userOrEmail,
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: S.current.password,
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscureText = !_obscureText),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submitLogin(),
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            const SizedBox(height: 8),
                            CheckboxListTile(
                              title: Text(S.current.keepSession),
                              value: _keepSession,
                              onChanged: (v) => setState(() => _keepSession = v ?? true),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _submitLogin,
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : Text(S.current.signIn),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () => context.go(AppRoutes.register),
                                child: Text(S.current.signUp),
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.go(AppRoutes.forgotPassword),
                              child: Text(S.current.forgotPassword),
                            ),
                          ],
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
        'Filmoly',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
