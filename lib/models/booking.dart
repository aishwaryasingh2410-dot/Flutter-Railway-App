import 'package:flutter/foundation.dart';

import 'train.dart';

enum BookingStatus { confirmed, cancelled }

@immutable
class Booking {
  const Booking({
    required this.id,
    required this.pnr,
    required this.train,
    required this.journeyDate,
    required this.passengerName,
    required this.status,
    required this.bookedAt,
  });

  final String id;
  final String pnr;
  final Train train;
  final DateTime journeyDate;
  final String passengerName;
  final BookingStatus status;
  final DateTime bookedAt;
}
