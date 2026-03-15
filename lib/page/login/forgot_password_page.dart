import 'package:filmoly/api/filmoly_api.dart';
import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/generated/l10n.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:filmoly/widget/components_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showCodeAndPassword = false;
  bool _obscureText = true;
  bool _isLoadingSend = false;
  bool _isLoadingConfirm = false;

  @override
  void dispose() {
    _loginController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    setState(() => _isLoadingSend = true);
    try {
      final result = await FilmolyApi.forgotPassword(_loginController.text.trim());
      if (!mounted) return;
      if (result['success'] == true) {
        setState(() => _showCodeAndPassword = true);
        showCustomSnackBar(S.current.codeSent, type: 1);
      } else {
        showCustomSnackBar(result['message'] as String? ?? 'Error', type: -1);
      }
    } finally {
      if (mounted) setState(() => _isLoadingSend = false);
    }
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    unFocusGlobal();
    setState(() => _isLoadingConfirm = true);
    try {
      final code = _codeController.text.replaceAll(RegExp(r'\D'), '');
      if (code.length != 6) {
        showCustomSnackBar(S.current.code6Digits, type: -1);
        return;
      }
      final result = await FilmolyApi.resetPassword(
        login: _loginController.text.trim(),
        code: code,
        newPassword: _passwordController.text,
      );
      if (!mounted) return;
      if (result['success'] == true) {
        showCustomSnackBar(S.current.passwordChanged, type: 1);
        context.go(AppRoutes.login);
      } else {
        showCustomSnackBar(result['message'] as String? ?? 'Error', type: -1);
      }
    } finally {
      if (mounted) setState(() => _isLoadingConfirm = false);
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _loginController,
                              decoration: InputDecoration(
                                labelText: '${S.current.userOrEmail} / ${S.current.email}',
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              validator: (v) =>
                                  (v == null || v.isEmpty) ? S.current.fieldRequired : null,
                            ),
                            if (!_showCodeAndPassword) ...[
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoadingSend ? null : _sendCode,
                              child: _isLoadingSend
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(S.current.sendCode),
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
                            if (_showCodeAndPassword) ...[
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _codeController,
                            decoration: InputDecoration(
                              labelText: S.current.verificationCode,
                              prefixIcon: const Icon(Icons.pin_outlined),
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) return S.current.fieldRequired;
                              if (v.length != 6) return S.current.code6Digits;
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: S.current.newPassword,
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
                            onFieldSubmitted: (_) => _resetPassword(),
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
                              onPressed: _isLoadingConfirm ? null : _resetPassword,
                              child: _isLoadingConfirm
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(S.current.confirm),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => setState(() => _showCodeAndPassword = false),
                              child: Text(S.current.back),
                            ),
                          ),
                            ],
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
}
