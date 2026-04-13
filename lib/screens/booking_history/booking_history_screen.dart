import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/booking.dart';
import '../../models/issued_ticket.dart';
import '../../providers/bookings_provider.dart';
import '../../providers/local_ticket_history_provider.dart';
import '../../theme/fyp_colors.dart';
import '../../widgets/issued_ticket_field_rows.dart';

/// Booking / ticket history — suburban e-tickets + legacy train bookings.
class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localTickets = ref.watch(localTicketHistoryProvider);
    final bookings = ref.watch(bookingsProvider);
    final confirmed = bookings.where((b) => b.status == BookingStatus.confirmed).toList();
    final dateFmt = DateFormat.yMMMd();
    final dateShort = DateFormat('dd/MM/yy');

    if (localTickets.isEmpty && confirmed.isEmpty) {
      return const ColoredBox(
        color: Color(0xFF121212),
        child: Center(
          child: Text(
            'No bookings yet',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }

    return ColoredBox(
      color: const Color(0xFF121212),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...localTickets.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _IssuedTicketHistoryCard(
                ticket: t,
                dateStr: dateShort.format(t.issueDate),
              ),
            ),
          ),
          ...confirmed.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _LegacyBookingCard(b: b, dateFmt: dateFmt),
            ),
          ),
        ],
      ),
    );
  }
}

class _IssuedTicketHistoryCard extends StatelessWidget {
  const _IssuedTicketHistoryCard({
    required this.ticket,
    required this.dateStr,
  });

  final IssuedTicket ticket;
  final String dateStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF00E5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'E-Ticket Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: FypColors.iconBlue.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.train, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Train Ticket',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: IssuedTicketFieldRows(
                  ticket: ticket,
                  dateStr: dateStr,
                ),
              ),
              Container(height: 4, color: Colors.red.shade700),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegacyBookingCard extends StatelessWidget {
  const _LegacyBookingCard({
    required this.b,
    required this.dateFmt,
  });

  final Booking b;
  final DateFormat dateFmt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF00E5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'E-Ticket Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: FypColors.iconBlue.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.train, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Train Ticket',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${b.train.name} · ${b.train.number}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text('PNR ${b.pnr} · ${dateFmt.format(b.journeyDate)}'),
                    Text('${b.train.fromName} → ${b.train.toName}'),
                    Text('${b.passengerName} · ₹${b.train.fare.toStringAsFixed(0)}'),
                  ],
                ),
              ),
              Container(height: 4, color: Colors.red.shade700),
            ],
          ),
        ),
      ],
    );
  }
}
