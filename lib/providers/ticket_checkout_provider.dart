import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ticket_fare_calculator.dart';

@immutable
class TicketCheckoutState {
  const TicketCheckoutState({
    required this.isReturn,
    required this.passengerCount,
    required this.ordinary,
    required this.firstClass,
  });

  final bool isReturn;
  final int passengerCount;
  final bool ordinary;
  final bool firstClass;

  int get fareRupees => TicketFareCalculator.totalRupees(
        isReturn: isReturn,
        passengers: passengerCount,
        firstClass: firstClass,
      );

  TicketCheckoutState copyWith({
    bool? isReturn,
    int? passengerCount,
    bool? ordinary,
    bool? firstClass,
  }) {
    return TicketCheckoutState(
      isReturn: isReturn ?? this.isReturn,
      passengerCount: passengerCount ?? this.passengerCount,
      ordinary: ordinary ?? this.ordinary,
      firstClass: firstClass ?? this.firstClass,
    );
  }
}

class TicketCheckoutNotifier extends StateNotifier<TicketCheckoutState> {
  TicketCheckoutNotifier()
      : super(
          const TicketCheckoutState(
            isReturn: false,
            passengerCount: 1,
            ordinary: true,
            firstClass: false,
          ),
        );

  void reset() {
    state = const TicketCheckoutState(
      isReturn: false,
      passengerCount: 1,
      ordinary: true,
      firstClass: false,
    );
  }

  void setReturnTicket(bool value) => state = state.copyWith(isReturn: value);

  void setPassengerCount(int n) =>
      state = state.copyWith(passengerCount: n.clamp(1, 4));

  void setOrdinary(bool value) => state = state.copyWith(ordinary: value);

  void setFirstClass(bool value) => state = state.copyWith(firstClass: value);
}

final ticketCheckoutProvider =
    StateNotifierProvider<TicketCheckoutNotifier, TicketCheckoutState>((ref) {
  return TicketCheckoutNotifier();
});
