import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/train.dart';

class TrainResultCard extends StatelessWidget {
  const TrainResultCard({
    super.key,
    required this.train,
    this.onBook,
  });

  final Train train;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeFmt = DateFormat.Hm();
    final duration = Duration(minutes: train.durationMinutes);
    final hours = duration.inHours;
    final mins = duration.inMinutes.remainder(60);
    final durLabel = hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        train.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${train.number} · ${train.coachClass}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '₹${train.fare.toStringAsFixed(0)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _TimeBlock(
                  label: 'Departure',
                  code: train.fromCode,
                  time: timeFmt.format(train.departure),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, size: 18, color: theme.colorScheme.outline),
                      Text(
                        durLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _TimeBlock(
                  label: 'Arrival',
                  code: train.toCode,
                  time: timeFmt.format(train.arrival),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.event_seat_outlined,
                  size: 18,
                  color: theme.colorScheme.tertiary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${train.availableSeats} seats left',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                if (onBook != null)
                  FilledButton.tonal(
                    onPressed: onBook,
                    child: const Text('Book'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  const _TimeBlock({
    required this.label,
    required this.code,
    required this.time,
  });

  final String label;
  final String code;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            time,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            code,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
