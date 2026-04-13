import 'package:flutter/foundation.dart';

/// A scheduled train offering between two stations.
@immutable
class Train {
  const Train({
    required this.id,
    required this.name,
    required this.number,
    required this.fromCode,
    required this.fromName,
    required this.toCode,
    required this.toName,
    required this.departure,
    required this.arrival,
    required this.durationMinutes,
    required this.availableSeats,
    required this.fare,
    required this.coachClass,
  });

  final String id;
  final String name;
  final String number;
  final String fromCode;
  final String fromName;
  final String toCode;
  final String toName;
  final DateTime departure;
  final DateTime arrival;
  final int durationMinutes;
  final int availableSeats;
  final double fare;
  final String coachClass;

  String get routeLabel => '$fromName → $toName';
}
