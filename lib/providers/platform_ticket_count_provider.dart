import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Selected platform ticket count (1–4).
final platformTicketCountProvider = StateProvider<int>((ref) => 3);
