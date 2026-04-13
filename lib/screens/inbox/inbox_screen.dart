import 'package:flutter/material.dart';

import '../../theme/fyp_colors.dart';

/// Inbox placeholder matching reference (“My Inbox” on periwinkle).
class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: FypColors.inboxBackground,
      child: Center(
        child: Text(
          'My Inbox',
          style: TextStyle(
            color: FypColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
