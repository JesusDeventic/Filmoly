import 'package:filmoly/core/global_functions.dart';
import 'package:filmoly/core/global_variables.dart';
import 'package:filmoly/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String _info = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _controller.forward();
    _startApp();
  }

  Future<void> _startApp() async {
    await loadAppVersion();
    setState(() => _info = 'Cargando...');
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    _navigate();
  }

  void _navigate() {
    if (globalCurrentUser.username.isEmpty) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.6, 0.8, curve: Curves.easeInOut),
                  ),
                ),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildSplashImage(),
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.6, 0.8, curve: Curves.easeInOut),
                  ),
                ),
                child: _buildLogoImage(),
              ),
            ),
            if (_info.isNotEmpty)
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Center(
                  child: Text(
                    _info,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return Image.asset(
      'assets/logo.png',
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.movie_creation_outlined,
        color: Colors.white54,
        size: 120,
      ),
    );
  }

  Widget _buildLogoImage() {
    return Image.asset(
      'assets/logo.png',
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Text(
        'Filmoly',
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
