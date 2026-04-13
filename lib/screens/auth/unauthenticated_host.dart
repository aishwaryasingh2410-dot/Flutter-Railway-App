import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'logo_splash_screen.dart';
import 'welcome_screen.dart';

enum _AuthIntroPhase { splash, welcome, auth }

/// Logo → welcome → login stack (sign up / forgot as pushed routes).
class UnauthenticatedHost extends StatefulWidget {
  const UnauthenticatedHost({super.key, this.skipIntro = false});

  /// After sign-out, open login directly without splash/welcome.
  final bool skipIntro;

  @override
  State<UnauthenticatedHost> createState() => _UnauthenticatedHostState();
}

class _UnauthenticatedHostState extends State<UnauthenticatedHost> {
  late _AuthIntroPhase _phase;

  @override
  void initState() {
    super.initState();
    _phase = widget.skipIntro ? _AuthIntroPhase.auth : _AuthIntroPhase.splash;
  }

  @override
  void didUpdateWidget(covariant UnauthenticatedHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.skipIntro && !oldWidget.skipIntro) {
      setState(() => _phase = _AuthIntroPhase.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_phase) {
      case _AuthIntroPhase.splash:
        return LogoSplashScreen(
          onFinished: () {
            if (!mounted) return;
            setState(() => _phase = _AuthIntroPhase.welcome);
          },
        );
      case _AuthIntroPhase.welcome:
        return WelcomeScreen(
          onContinue: () {
            setState(() => _phase = _AuthIntroPhase.auth);
          },
        );
      case _AuthIntroPhase.auth:
        return const LoginScreen();
    }
  }
}
