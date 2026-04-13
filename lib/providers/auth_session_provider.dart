import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
sealed class AuthSession {
  const AuthSession();

  bool get isAuthenticated => this is AuthSignedIn;
}

@immutable
class AuthSignedOut extends AuthSession {
  const AuthSignedOut({required this.showIntroSequence});

  /// First install: logo → welcome → login. After [AuthSessionNotifier.signOut]: login only.
  final bool showIntroSequence;
}

@immutable
class AuthSignedIn extends AuthSession {
  const AuthSignedIn(this.email);

  final String email;
}

class AuthSessionNotifier extends StateNotifier<AuthSession> {
  AuthSessionNotifier() : super(const AuthSignedOut(showIntroSequence: true));

  void signIn(String email) {
    state = AuthSignedIn(email);
  }

  void signOut() {
    state = const AuthSignedOut(showIntroSequence: false);
  }
}

final authSessionProvider =
    StateNotifierProvider<AuthSessionNotifier, AuthSession>((ref) {
  return AuthSessionNotifier();
});
