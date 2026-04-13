import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Draft “To / From” fields for the Ticket Booking card (Riverpod).
@immutable
class FypTicketDraft {
  const FypTicketDraft({
    required this.to,
    required this.from,
  });

  final String to;
  final String from;

  FypTicketDraft copyWith({String? to, String? from}) {
    return FypTicketDraft(
      to: to ?? this.to,
      from: from ?? this.from,
    );
  }
}

class FypTicketDraftNotifier extends StateNotifier<FypTicketDraft> {
  FypTicketDraftNotifier()
      : super(const FypTicketDraft(to: '', from: ''));

  void setTo(String value) => state = state.copyWith(to: value);

  void setFrom(String value) => state = state.copyWith(from: value);
}

final fypTicketDraftProvider =
    StateNotifierProvider<FypTicketDraftNotifier, FypTicketDraft>((ref) {
  return FypTicketDraftNotifier();
});
