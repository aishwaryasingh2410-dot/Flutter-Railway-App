import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/auth_session_provider.dart';
import 'providers/theme_mode_provider.dart';
import 'screens/auth/unauthenticated_host.dart';
import 'screens/shell/main_navigation_shell.dart';
import 'theme/app_theme.dart';

class RailwayApp extends ConsumerWidget {
  const RailwayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final session = ref.watch(authSessionProvider);

    final Widget home = switch (session) {
      AuthSignedIn() => const MainNavigationShell(),
      AuthSignedOut(:final showIntroSequence) => UnauthenticatedHost(
          skipIntro: !showIntroSequence,
        ),
    };

    return MaterialApp(
      title: 'FinalYearProject',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: home,
    );
  }
}
