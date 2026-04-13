import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_session_provider.dart';
import 'auth_colors.dart';
import 'widgets/auth_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _register() {
    final name = _name.text.trim();
    final email = _email.text.trim();
    final p = _password.text;
    final c = _confirm.text;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your name')),
      );
      return;
    }
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email')),
      );
      return;
    }
    if (p.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }
    if (p != c) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    ref.read(authSessionProvider.notifier).signIn(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.loginSheet,
      appBar: AppBar(
        backgroundColor: AuthColors.appBarBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Create account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            AuthTextField(
              controller: _name,
              hintText: 'Full name',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 14),
            AuthTextField(
              controller: _email,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 14),
            AuthTextField(
              controller: _password,
              hintText: 'Password',
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 14),
            AuthTextField(
              controller: _confirm,
              hintText: 'Confirm password',
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _register(),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                onPressed: _register,
                child: const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(
                  color: AuthColors.signUpPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
