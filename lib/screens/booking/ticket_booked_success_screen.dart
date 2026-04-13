import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/bottom_nav_provider.dart';

/// Brief loading, then success toast style banner; then history tab (reference UI).
class TicketBookedSuccessScreen extends ConsumerStatefulWidget {
  const TicketBookedSuccessScreen({super.key});

  @override
  ConsumerState<TicketBookedSuccessScreen> createState() =>
      _TicketBookedSuccessScreenState();
}

class _TicketBookedSuccessScreenState
    extends ConsumerState<TicketBookedSuccessScreen> {
  bool _loading = true;
  bool _showBanner = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted || _finished) return;
    setState(() {
      _loading = false;
      _showBanner = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 2600));
    if (!mounted || _finished) return;
    _goToHistory();
  }

  void _goToHistory() {
    if (_finished) return;
    _finished = true;
    ref.read(bottomNavIndexProvider.notifier).state = 1;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!_loading && _showBanner) {
            _goToHistory();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_loading)
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Confirming booking…',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ],
              ),
            if (_showBanner)
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Tap anywhere to continue',
                          style: TextStyle(color: Colors.black38, fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade100,
                          shadowColor: Colors.black26,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.train_rounded,
                                  size: 28,
                                  color: Colors.amber.shade700,
                                ),
                                const SizedBox(width: 12),
                                const Flexible(
                                  child: Text(
                                    'Ticket Booked Successfully',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
