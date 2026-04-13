import 'package:flutter/material.dart';

import 'auth_colors.dart';
import 'widgets/local_train_art.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AuthColors.welcomeTop,
                    AuthColors.welcomeBottom,
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const Expanded(
                      flex: 3,
                      child: Center(
                        child: LocalTrainArt(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 22,
                            ),
                            decoration: BoxDecoration(
                              color: AuthColors.welcomePanel,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Text(
                              'Welcome to Mumbai Local Train Journey',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AuthColors.welcomeTitle,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                height: 1.35,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              onPressed: onContinue,
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
