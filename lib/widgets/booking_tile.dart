import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/booking.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
    super.key,
    required this.booking,
    this.onCancel,
  });

  final Booking booking;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();
    final timeFmt = DateFormat.Hm();
    final isCancelled = booking.status == BookingStatus.cancelled;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.train.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatusChip(status: booking.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${booking.train.number} · ${booking.train.coachClass}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _InfoChip(icon: Icons.confirmation_number_outlined, label: 'PNR ${booking.pnr}'),
                const SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.calendar_today_outlined,
                  label: dateFmt.format(booking.journeyDate),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${booking.train.fromName} → ${booking.train.toName}',
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              '${timeFmt.format(booking.train.departure)} · ${booking.passengerName}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (!isCancelled && onCancel != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancel ticket'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (label, color) = switch (status) {
      BookingStatus.confirmed => ('Confirmed', theme.colorScheme.primaryContainer),
      BookingStatus.cancelled => ('Cancelled', theme.colorScheme.errorContainer),
    };
    return Chip(
      label: Text(label),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      labelStyle: theme.textTheme.labelMedium,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      avatar: Icon(icon, size: 16, color: theme.colorScheme.primary),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}
