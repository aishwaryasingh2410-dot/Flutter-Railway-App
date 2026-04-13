import 'package:flutter/foundation.dart';

@immutable
class IssuedTicket {
  const IssuedTicket({
    required this.fromStation,
    required this.toStation,
    required this.isReturn,
    required this.passengers,
    required this.ordinary,
    required this.firstClass,
    required this.fareRupees,
    required this.ticketNumber,
    required this.issueDate,
  });

  final String fromStation;
  final String toStation;
  final bool isReturn;
  final int passengers;
  final bool ordinary;
  final bool firstClass;
  final int fareRupees;
  final String ticketNumber;
  final DateTime issueDate;

  String get ticketTypeLabel => isReturn ? 'Return Ticket' : 'Single Ticket';

  String get classLabel => firstClass ? 'First Class' : 'Second Class';
}
