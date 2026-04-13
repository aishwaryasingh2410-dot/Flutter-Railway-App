import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bottom_nav_provider.dart';
import '../../theme/fyp_colors.dart';
import '../booking_history/booking_history_screen.dart';
import '../home/home_screen.dart';
import '../inbox/inbox_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule/schedule_screen.dart';

/// Shell: lavender app bar “FinalYearProject”, yellow 5-tab bottom bar (reference UI).
class MainNavigationShell extends ConsumerWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      backgroundColor: FypColors.homeBackground,
      appBar: AppBar(
        backgroundColor: FypColors.appBarLavender,
        foregroundColor: FypColors.white,
        centerTitle: false,
        elevation: 0,
        title: const Text(
          'FinalYearProject',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: IndexedStack(
        index: index,
        children: const [
          HomeScreen(),
          BookingHistoryScreen(),
          ScheduleScreen(),
          InboxScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) => ref.read(bottomNavIndexProvider.notifier).state = value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: FypColors.accentYellow,
          selectedItemColor: const Color(0xFF0D47A1),
          unselectedItemColor: const Color(0xFF1565C0),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment),
              label: 'B. History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.train_outlined),
              activeIcon: Icon(Icons.train),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              activeIcon: Icon(Icons.mail),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
