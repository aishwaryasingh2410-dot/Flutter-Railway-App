import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Index for bottom navigation: Home, B. History, Schedule, Inbox, Profile.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
