import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bottom_nav_provider.dart';
import '../../providers/fyp_ticket_draft_provider.dart';
import '../../providers/ticket_checkout_provider.dart';
import '../../theme/fyp_colors.dart';
import '../../widgets/station_autocomplete_field.dart';
import '../booking/ticket_details_screen.dart';
import '../platform/platform_ticket_screen.dart';

/// Home tab — Ticket Booking card + 2×2 quick actions (design reference UI).
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _toCtrl;
  late final TextEditingController _fromCtrl;
  late final FocusNode _toFocus;
  late final FocusNode _fromFocus;

  @override
  void initState() {
    super.initState();
    _toCtrl = TextEditingController();
    _fromCtrl = TextEditingController();
    _toFocus = FocusNode();
    _fromFocus = FocusNode();
  }

  @override
  void dispose() {
    _toCtrl.dispose();
    _fromCtrl.dispose();
    _toFocus.dispose();
    _fromFocus.dispose();
    super.dispose();
  }

  OutlineInputBorder _fieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: FypColors.black, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = ref.read(bottomNavIndexProvider.notifier);

    return ColoredBox(
      color: FypColors.homeBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TicketBookingCard(
              toController: _toCtrl,
              fromController: _fromCtrl,
              toFocus: _toFocus,
              fromFocus: _fromFocus,
              fieldBorder: _fieldBorder(),
              onToChanged: (v) => ref.read(fypTicketDraftProvider.notifier).setTo(v),
              onFromChanged: (v) => ref.read(fypTicketDraftProvider.notifier).setFrom(v),
              onNext: () {
                final from = _fromCtrl.text.trim();
                final to = _toCtrl.text.trim();
                if (from.isEmpty || to.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select both From and To stations'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.black87,
                    ),
                  );
                  return;
                }
                ref.read(fypTicketDraftProvider.notifier).setFrom(from);
                ref.read(fypTicketDraftProvider.notifier).setTo(to);
                ref.read(ticketCheckoutProvider.notifier).reset();
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const TicketDetailsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _QuickActionsGrid(
              onMap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Using MAP'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black87,
                  ),
                );
              },
              onFastBooking: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fast Booking'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black87,
                  ),
                );
              },
              onPlatformTicket: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PlatformTicketScreen(),
                  ),
                );
              },
              onMonthlyPass: () => nav.state = 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketBookingCard extends StatelessWidget {
  const _TicketBookingCard({
    required this.toController,
    required this.fromController,
    required this.toFocus,
    required this.fromFocus,
    required this.fieldBorder,
    required this.onToChanged,
    required this.onFromChanged,
    required this.onNext,
  });

  final TextEditingController toController;
  final TextEditingController fromController;
  final FocusNode toFocus;
  final FocusNode fromFocus;
  final OutlineInputBorder fieldBorder;
  final ValueChanged<String> onToChanged;
  final ValueChanged<String> onFromChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FypColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: FypColors.ticketHeaderCyan,
            child: const Text(
              'Ticket Booking',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: FypColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'To :',
                  style: TextStyle(
                    color: FypColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                StationAutocompleteField(
                  controller: toController,
                  focusNode: toFocus,
                  fieldBorder: fieldBorder,
                  onChanged: onToChanged,
                ),
                const SizedBox(height: 16),
                const Text(
                  'From :',
                  style: TextStyle(
                    color: FypColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                StationAutocompleteField(
                  controller: fromController,
                  focusNode: fromFocus,
                  fieldBorder: fieldBorder,
                  onChanged: onFromChanged,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Material(
                    color: FypColors.nextGreen,
                    borderRadius: BorderRadius.circular(999),
                    elevation: 2,
                    child: InkWell(
                      onTap: onNext,
                      borderRadius: BorderRadius.circular(999),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                        child: Text(
                          'NEXT...',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({
    required this.onMap,
    required this.onFastBooking,
    required this.onPlatformTicket,
    required this.onMonthlyPass,
  });

  final VoidCallback onMap;
  final VoidCallback onFastBooking;
  final VoidCallback onPlatformTicket;
  final VoidCallback onMonthlyPass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FypColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.05,
        children: [
          _YellowTile(
            icon: Icons.add_location_alt,
            label: 'Using MAP',
            onTap: onMap,
          ),
          _YellowTile(
            icon: Icons.phone_android,
            label: 'Fast Booking',
            onTap: onFastBooking,
          ),
          _YellowTile(
            icon: Icons.transfer_within_a_station,
            label: 'Platform Ticket',
            onTap: onPlatformTicket,
          ),
          _YellowTile(
            icon: Icons.menu_book,
            label: 'Monthly Pass',
            onTap: onMonthlyPass,
          ),
        ],
      ),
    );
  }
}

class _YellowTile extends StatelessWidget {
  const _YellowTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FypColors.accentYellow,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: FypColors.iconBlue),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: FypColors.iconBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
