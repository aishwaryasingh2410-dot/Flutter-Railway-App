import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/issued_ticket.dart';
import '../../providers/fyp_ticket_draft_provider.dart';
import '../../providers/ticket_checkout_provider.dart';
import '../../theme/fyp_colors.dart';
import 'e_ticket_screen.dart';

/// After home NEXT — train type, passengers, class, live fare (reference UI).
class TicketDetailsScreen extends ConsumerWidget {
  const TicketDetailsScreen({super.key});

  static const Color _headerPurple = Color(0xFF5E35B1);
  static const Color _headerTextYellow = Color(0xFFFFEB3B);
  static const Color _lavenderBg = Color(0xFFB39DDB);
  static const Color _fareLabelYellow = Color(0xFFFFFF00);
  static const Color _fareValueCyan = Color(0xFF00E5FF);
  static const Color _confirmOrange = Color(0xFFFF6D00);
  static const Color _goBackMaroon = Color(0xFF6D1B1B);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(fypTicketDraftProvider);
    final checkout = ref.watch(ticketCheckoutProvider);
    final notifier = ref.read(ticketCheckoutProvider.notifier);

    return Scaffold(
      backgroundColor: _lavenderBg,
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
            _RouteRow(from: draft.from, to: draft.to),
            const SizedBox(height: 18),
            _Section(
              title: 'Change Train Type',
              child: _PillWrap(
                child: Row(
                  children: [
                    Expanded(
                      child: _ChoiceChip(
                        label: 'Single Ticket',
                        selected: !checkout.isReturn,
                        onSelected: () => notifier.setReturnTicket(false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _ChoiceChip(
                        label: 'Return Ticket',
                        selected: checkout.isReturn,
                        onSelected: () => notifier.setReturnTicket(true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            _Section(
              title: 'Change Number of Tickets',
              child: _PillWrap(
                child: Row(
                  children: List.generate(4, (i) {
                    final n = i + 1;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
                        child: _ChoiceChip(
                          label: '$n',
                          selected: checkout.passengerCount == n,
                          onSelected: () => notifier.setPassengerCount(n),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 14),
            _Section(
              title: 'Journey Type',
              child: _PillWrap(
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color(0xFF0097A7);
                    }
                    return null;
                  }),
                  checkColor: Colors.white,
                  title: const Text(
                    'Ordinary',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: FypColors.black,
                    ),
                  ),
                  value: checkout.ordinary,
                  onChanged: (v) => notifier.setOrdinary(v ?? true),
                ),
              ),
            ),
            const SizedBox(height: 14),
            _Section(
              title: 'Change Class',
              child: _PillWrap(
                child: Row(
                  children: [
                    Expanded(
                      child: _ChoiceChip(
                        label: 'First Class',
                        selected: checkout.firstClass,
                        onSelected: () => notifier.setFirstClass(true),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _ChoiceChip(
                        label: 'Second Class',
                        selected: !checkout.firstClass,
                        onSelected: () => notifier.setFirstClass(false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    decoration: BoxDecoration(
                      color: _fareLabelYellow,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Total Fare:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: FypColors.iconBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    decoration: BoxDecoration(
                      color: _fareValueCyan,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Total Fare: ${checkout.fareRupees} rupees',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: FypColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _BigActionButton(
              label: 'CONFIRM',
              background: _confirmOrange,
              onPressed: () {
                final number = (10000 + DateTime.now().millisecondsSinceEpoch % 90000)
                    .toString();
                final issued = IssuedTicket(
                  fromStation: draft.from,
                  toStation: draft.to,
                  isReturn: checkout.isReturn,
                  passengers: checkout.passengerCount,
                  ordinary: checkout.ordinary,
                  firstClass: checkout.firstClass,
                  fareRupees: checkout.fareRupees,
                  ticketNumber: number,
                  issueDate: DateTime.now(),
                );
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => ETicketScreen(ticket: issued),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            _BigActionButton(
              label: 'GO BACK',
              background: _goBackMaroon,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({required this.from, required this.to});

  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StationChip(text: from.isEmpty ? '—' : from),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.keyboard_double_arrow_right,
            color: Colors.deepPurple.shade700,
            size: 32,
          ),
        ),
        Expanded(
          child: _StationChip(text: to.isEmpty ? '—' : to),
        ),
      ],
    );
  }
}

class _StationChip extends StatelessWidget {
  const _StationChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: FypColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: FypColors.black,
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: TicketDetailsScreen._headerPurple,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: TicketDetailsScreen._headerTextYellow,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _PillWrap extends StatelessWidget {
  const _PillWrap({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: FypColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
      ),
      child: child,
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.deepPurple.shade100 : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.deepPurple.shade900 : FypColors.black,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _BigActionButton extends StatelessWidget {
  const _BigActionButton({
    required this.label,
    required this.background,
    required this.onPressed,
  });

  final String label;
  final Color background;
  final VoidCallback onPressed;

  static const Color _cyanText = Color(0xFF00E5FF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: Colors.black38,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _cyanText,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
