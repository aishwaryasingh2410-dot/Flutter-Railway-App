import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/train.dart';
import '../../providers/bookings_provider.dart';
import '../../providers/train_service_provider.dart';
import '../../widgets/train_result_card.dart';

class SearchTrainsScreen extends ConsumerStatefulWidget {
  const SearchTrainsScreen({super.key});

  @override
  ConsumerState<SearchTrainsScreen> createState() => _SearchTrainsScreenState();
}

class _SearchTrainsScreenState extends ConsumerState<SearchTrainsScreen> {
  final _fromCtrl = TextEditingController(text: 'New Delhi');
  final _toCtrl = TextEditingController(text: 'Mumbai Central');
  DateTime _journeyDate = DateTime.now();
  List<Train> _results = [];
  bool _searched = false;

  @override
  void dispose() {
    _fromCtrl.dispose();
    _toCtrl.dispose();
    super.dispose();
  }

  void _runSearch() {
    final svc = ref.read(trainServiceProvider);
    setState(() {
      _results = svc.search(
        fromQuery: _fromCtrl.text,
        toQuery: _toCtrl.text,
        journeyDate: _journeyDate,
      );
      _searched = true;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _journeyDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 120)),
    );
    if (picked != null) {
      setState(() => _journeyDate = picked);
    }
  }

  Future<void> _book(Train train) async {
    final nameCtrl = TextEditingController(text: 'Mahi Kumar');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${train.name} (${train.number})'),
              const SizedBox(height: 8),
              Text('${train.fromName} → ${train.toName}'),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Passenger name',
                ),
                textCapitalization: TextCapitalization.words,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Back'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Book'),
            ),
          ],
        );
      },
    );
    final passengerName =
        nameCtrl.text.trim().isEmpty ? 'Passenger' : nameCtrl.text.trim();
    nameCtrl.dispose();

    if (ok != true) return;
    ref.read(bookingsProvider.notifier).addBooking(
          train: train,
          passengerName: passengerName,
          journeyDate: _journeyDate,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ticket booked (mock). Check My bookings.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          controller: _fromCtrl,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'From',
            hintText: 'Station name or code',
            prefixIcon: Icon(Icons.trip_origin),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _toCtrl,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'To',
            hintText: 'Station name or code',
            prefixIcon: Icon(Icons.place_outlined),
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_month_outlined),
          title: const Text('Journey date'),
          subtitle: Text(dateFmt.format(_journeyDate)),
          trailing: const Icon(Icons.edit_calendar_outlined),
          onTap: _pickDate,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _runSearch,
          icon: const Icon(Icons.search),
          label: const Text('Search trains'),
        ),
        const SizedBox(height: 24),
        if (_searched && _results.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No trains found. Try “New Delhi” → “Mumbai Central” or “Chennai Central” → “Coimbatore”.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ..._results.map(
          (t) => TrainResultCard(
            train: t,
            onBook: () => _book(t),
          ),
        ),
      ],
    );
  }
}
