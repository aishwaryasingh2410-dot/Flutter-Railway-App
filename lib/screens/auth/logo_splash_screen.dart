import 'package:flutter/material.dart';

import 'auth_colors.dart';

/// First launch: logo + title; tap or timer continues to welcome.
class LogoSplashScreen extends StatefulWidget {
  const LogoSplashScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<LogoSplashScreen> createState() => _LogoSplashScreenState();
}

class _LogoSplashScreenState extends State<LogoSplashScreen> {
  bool _done = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2600), () {
      if (!mounted || _done) return;
      _finish();
    });
  }

  void _finish() {
    if (_done) return;
    _done = true;
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A237E),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _finish,
          child: Column(
            children: [
              AppBar(
                backgroundColor: AuthColors.appBarBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: const Text(
                  'FinalYearProject',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.train_rounded,
                          size: 88,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Mumbai Local',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Smart suburban travel',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'Tap anywhere to continue',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 13,
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
    );
  }
}
