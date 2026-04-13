import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';

final userProfileProvider = Provider<UserProfile>((ref) {
  return const UserProfile(
    displayName: 'Mahi Kumar',
    email: 'mahi.kumar@example.com',
    phone: '+91 98765 43210',
    irctcId: 'MK******01',
  );
});
