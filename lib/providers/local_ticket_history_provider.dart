import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/issued_ticket.dart';

class LocalTicketHistoryNotifier extends StateNotifier<List<IssuedTicket>> {
  LocalTicketHistoryNotifier() : super(const []);

  void addTicket(IssuedTicket ticket) {
    state = [ticket, ...state];
  }
}

final localTicketHistoryProvider =
    StateNotifierProvider<LocalTicketHistoryNotifier, List<IssuedTicket>>((ref) {
  return LocalTicketHistoryNotifier();
});
