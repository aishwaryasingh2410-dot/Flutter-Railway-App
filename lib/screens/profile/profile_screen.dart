import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_session_provider.dart';
import '../../theme/fyp_colors.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  String name = "Aishu";
  String phone = "8104676189";
  String email = "aishu@gmail.com";
  String password = "123123";

  void _showEditDialog() {
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);
    final passwordController = TextEditingController(text: password);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Details"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
                TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Password")),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  phone = phoneController.text;
                  email = emailController.text;
                  password = passwordController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

                    // 🔥 PROFILE CARD + EDIT BUTTON
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: FypColors.profileDeepBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.black,
                                child: Icon(Icons.person, size: 44, color: Colors.white),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: FypColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ✏️ EDIT BUTTON
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: _showEditDialog,
                        )
                      ],
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
                      child: Column(
                        children: [
                          _InfoRow(label: 'Name', value: name),
                          const Divider(height: 1),
                          _InfoRow(label: 'Number', value: phone),
                          const Divider(height: 1),
                          _InfoRow(label: 'E-mail', value: email),
                          const Divider(height: 1),
                          _InfoRow(label: 'Password', value: password),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔥 LOGOUT
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