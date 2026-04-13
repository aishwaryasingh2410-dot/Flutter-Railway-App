import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_session_provider.dart';
import '../../theme/fyp_colors.dart';

/// Profile — lavender gradient header, info card, LOG OUT.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: FypColors.appBarLavender,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8E9EFF),
                    Color(0xFFE8EAF6),
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: FypColors.profileDeepBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, size: 44, color: Colors.white),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Amar',
                            style: TextStyle(
                              color: FypColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: FypColors.profileDeepBlue, width: 1.5),
                      ),
                      child: const Column(
                        children: [
                          _InfoRow(label: 'Name', value: 'Amar'),
                          Divider(height: 1),
                          _InfoRow(label: 'Number', value: '69696969'),
                          Divider(height: 1),
                          _InfoRow(label: 'E-mail', value: 'amar@gmail.com'),
                          Divider(height: 1),
                          _InfoRow(label: 'Password', value: '123123'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Material(
                      color: FypColors.appBarLavender,
                      borderRadius: BorderRadius.circular(12),
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          ref.read(authSessionProvider.notifier).signOut();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'LOG OUT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: FypColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label :',
              style: const TextStyle(
                color: FypColors.profileDeepBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: FypColors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
