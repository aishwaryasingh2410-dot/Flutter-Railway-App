import 'package:flutter/material.dart';

import '../../theme/fyp_colors.dart';

class _ScheduleRow {
  const _ScheduleRow({
    required this.time,
    required this.from,
    required this.to,
    required this.platform,
    required this.code,
  });

  final String time;
  final String from;
  final String to;
  final String platform;
  final String code;
}

/// Train schedule list — sky blue background, three-part cards.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const _rows = [
    _ScheduleRow(
      time: '9:00 AM',
      from: 'Dadar',
      to: 'Ghatkopar',
      platform: 'PF2',
      code: '8891C',
    ),
    _ScheduleRow(
      time: '10:15 AM',
      from: 'Ghatkopar',
      to: 'Thane',
      platform: 'PF1',
      code: '9602A',
    ),
    _ScheduleRow(
      time: '11:40 AM',
      from: 'Thane',
      to: 'CST',
      platform: 'PF4',
      code: '7712B',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FypColors.scheduleBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF2F3E4E),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(color: Color(0xFF81D4FA)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(color: Color(0xFF81D4FA)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: _rows.length,
              itemBuilder: (context, i) {
                final r = _rows[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 26,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF90CAF9),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.time,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(r.from, style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 30,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                            color: FypColors.scheduleCyan,
                            child: Text(
                              r.to,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 24,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF90CAF9),
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(r.platform, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(r.code, style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
