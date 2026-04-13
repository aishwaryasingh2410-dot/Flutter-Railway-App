import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  const UserProfile({
    required this.displayName,
    required this.email,
    required this.phone,
    required this.irctcId,
  });

  final String displayName;
  final String email;
  final String phone;
  final String irctcId;
}
