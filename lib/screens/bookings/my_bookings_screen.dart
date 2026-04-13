import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/booking.dart';
import '../../providers/bookings_provider.dart';
import '../../widgets/booking_tile.dart';
import '../../widgets/empty_placeholder.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingsProvider);
    final active = bookings.where((b) => b.status == BookingStatus.confirmed).toList();

    if (active.isEmpty) {
      return EmptyPlaceholder(
        icon: Icons.confirmation_number_outlined,
        title: 'No active bookings',
        subtitle: 'Search for a train and book a ticket to see it listed here.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: active.length,
      itemBuilder: (context, i) {
        final b = active[i];
        return BookingTile(
          booking: b,
          onCancel: () async {
            final sure = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel booking?'),
                content: Text('PNR ${b.pnr} will be cancelled (mock).'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Keep'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Cancel ticket'),
                  ),
                ],
              ),
            );
            if (sure == true && context.mounted) {
              ref.read(bookingsProvider.notifier).cancel(b.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled (mock).')),
              );
            }
          },
        );
      },
    );
  }
}
