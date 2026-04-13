import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/platform_ticket_count_provider.dart';
import '../../theme/fyp_colors.dart';

/// Platform ticket booking — deep purple body, cyan header, red strip, lime tiles.
class PlatformTicketScreen extends ConsumerStatefulWidget {
  const PlatformTicketScreen({super.key});

  @override
  ConsumerState<PlatformTicketScreen> createState() =>
      _PlatformTicketScreenState();
}

class _PlatformTicketScreenState extends ConsumerState<PlatformTicketScreen> {
  static const Color _purpleBg = Color(0xFF7B1FA2);
  static const Color _headerCyan = Color(0xFF00E5FF);
  static const Color _fieldLavender = Color(0xFFB39DDB);
  static const Color _redStrip = Color(0xFFF44336);
  static const Color _limeTile = Color(0xFFCDDC39);

  late final TextEditingController _stationCtrl;

  @override
  void initState() {
    super.initState();
    _stationCtrl = TextEditingController(text: 'Ghatkopar');
  }

  @override
  void dispose() {
    _stationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(platformTicketCountProvider);

    return Scaffold(
      backgroundColor: _purpleBg,
      appBar: AppBar(
        backgroundColor: FypColors.appBarLavender,
        foregroundColor: FypColors.white,
        title: const Text('FinalYearProject'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _headerCyan,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Platform Ticket Booking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: FypColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _stationCtrl,
              style: const TextStyle(color: FypColors.black, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                fillColor: _fieldLavender,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Ticket Count',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: FypColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: _redStrip,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (i) {
                  final n = i + 1;
                  final selected = count == n;
                  return GestureDetector(
                    onTap: () =>
                        ref.read(platformTicketCountProvider.notifier).state = n,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _limeTile,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected ? _headerCyan : FypColors.black,
                          width: selected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selected ? Icons.check_box : Icons.check_box_outline_blank,
                            size: 18,
                            color: FypColors.black,
                          ),
                          Text(
                            '$n',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: Material(
                color: _headerCyan,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Booked $count × ${_stationCtrl.text}'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 56, vertical: 14),
                    child: Text(
                      'BOOK',
                      style: TextStyle(
                        color: FypColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
