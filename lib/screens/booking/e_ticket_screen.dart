import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/issued_ticket.dart';
import '../../providers/local_ticket_history_provider.dart';
import '../../theme/fyp_colors.dart';
import '../../widgets/issued_ticket_field_rows.dart';
import 'ticket_booked_success_screen.dart';

/// Final issued e-ticket (reference UI).
class ETicketScreen extends ConsumerWidget {
  const ETicketScreen({super.key, required this.ticket});

  final IssuedTicket ticket;

  static const Color _tealHeader = Color(0xFF00BCD4);
  static const Color _ticketBar = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateStr = DateFormat('dd/MM/yy').format(ticket.issueDate);

    return Scaffold(
      backgroundColor: const Color(0xFFB39DDB),
      appBar: AppBar(
        backgroundColor: FypColors.appBarLavender,
        foregroundColor: FypColors.white,
        elevation: 0,
        title: const Text(
          'FinalYearProject',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                color: _tealHeader,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'E-Ticket Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: FypColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: FypColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    color: _ticketBar,
                    child: const Row(
                      children: [
                        Icon(Icons.train, color: FypColors.white, size: 26),
                        SizedBox(width: 10),
                        Text(
                          'Train Ticket',
                          style: TextStyle(
                            color: FypColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IssuedTicketFieldRows(
                            ticket: ticket,
                            dateStr: dateStr,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            _FakeBarcode(width: 44, height: 160),
                            const SizedBox(height: 6),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(height: 10, color: Colors.red.shade700),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Material(
              color: FypColors.accentYellow,
              borderRadius: BorderRadius.circular(16),
              elevation: 4,
              child: InkWell(
                onTap: () {
                  ref.read(localTicketHistoryProvider.notifier).addTicket(ticket);
                  Navigator.of(context).pushReplacement<void, void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const TicketBookedSuccessScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'BOOK A TICKET',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: FypColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
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

class _FakeBarcode extends StatelessWidget {
  const _FakeBarcode({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(22, (i) {
          final thick = i % 4 == 0;
          return Container(
            width: thick ? 3.0 : 1.4,
            height: height,
            color: i.isEven ? Colors.black : Colors.white,
          );
        }),
      ),
    );
  }
}
