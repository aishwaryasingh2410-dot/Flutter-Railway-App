import '../models/train.dart';

/// Mock train catalogue and search. Replace with API calls in production.
class TrainService {
  TrainService() : _trains = _buildMockTrains();

  final List<Train> _trains;

  List<Train> get all => List.unmodifiable(_trains);

  /// Case-insensitive substring match on station names or codes.
  List<Train> search({
    required String fromQuery,
    required String toQuery,
    required DateTime journeyDate,
  }) {
    final from = fromQuery.trim().toLowerCase();
    final to = toQuery.trim().toLowerCase();
    if (from.isEmpty || to.isEmpty) {
      return [];
    }

    return _trains.where((t) {
      final matchesFrom = t.fromName.toLowerCase().contains(from) ||
          t.fromCode.toLowerCase().contains(from);
      final matchesTo =
          t.toName.toLowerCase().contains(to) || t.toCode.toLowerCase().contains(to);
      return matchesFrom && matchesTo;
    }).map((t) {
      // Align displayed times to the selected calendar day (mock behaviour).
      final d = DateTime(journeyDate.year, journeyDate.month, journeyDate.day);
      final dep = DateTime(d.year, d.month, d.day, t.departure.hour, t.departure.minute);
      final arr = DateTime(d.year, d.month, d.day, t.arrival.hour, t.arrival.minute);
      final adjustedArr = arr.isBefore(dep) ? arr.add(const Duration(days: 1)) : arr;
      final duration = adjustedArr.difference(dep).inMinutes;
      return Train(
        id: t.id,
        name: t.name,
        number: t.number,
        fromCode: t.fromCode,
        fromName: t.fromName,
        toCode: t.toCode,
        toName: t.toName,
        departure: dep,
        arrival: adjustedArr,
        durationMinutes: duration,
        availableSeats: t.availableSeats,
        fare: t.fare,
        coachClass: t.coachClass,
      );
    }).toList()
      ..sort((a, b) => a.departure.compareTo(b.departure));
  }
}

List<Train> _buildMockTrains() {
  Train t({
    required String id,
    required String name,
    required String number,
    required String fromCode,
    required String fromName,
    required String toCode,
    required String toName,
    required int depH,
    required int depM,
    required int arrH,
    required int arrM,
    required int seats,
    required double fare,
    String coachClass = 'Sleeper (SL)',
  }) {
    final base = DateTime(2026, 1, 1);
    final dep = DateTime(base.year, base.month, base.day, depH, depM);
    final arr = DateTime(base.year, base.month, base.day, arrH, arrM);
    final duration = arr.difference(dep).inMinutes;
    return Train(
      id: id,
      name: name,
      number: number,
      fromCode: fromCode,
      fromName: fromName,
      toCode: toCode,
      toName: toName,
      departure: dep,
      arrival: arr,
      durationMinutes: duration,
      availableSeats: seats,
      fare: fare,
      coachClass: coachClass,
    );
  }

  return [
    t(
      id: '1',
      name: 'Rajdhani Express',
      number: '12951',
      fromCode: 'NDLS',
      fromName: 'New Delhi',
      toCode: 'MMCT',
      toName: 'Mumbai Central',
      depH: 16,
      depM: 55,
      arrH: 8,
      arrM: 35,
      seats: 42,
      fare: 4120,
      coachClass: 'AC 2 Tier (2A)',
    ),
    t(
      id: '2',
      name: 'August Kranti Rajdhani',
      number: '12953',
      fromCode: 'NDLS',
      fromName: 'New Delhi',
      toCode: 'MMCT',
      toName: 'Mumbai Central',
      depH: 17,
      depM: 15,
      arrH: 9,
      arrM: 45,
      seats: 18,
      fare: 3980,
      coachClass: 'AC 3 Tier (3A)',
    ),
    t(
      id: '3',
      name: 'Howrah Rajdhani',
      number: '12301',
      fromCode: 'NDLS',
      fromName: 'New Delhi',
      toCode: 'HWH',
      toName: 'Howrah',
      depH: 16,
      depM: 50,
      arrH: 10,
      arrM: 0,
      seats: 27,
      fare: 4650,
      coachClass: 'AC 2 Tier (2A)',
    ),
    t(
      id: '4',
      name: 'Shatabdi Express',
      number: '12002',
      fromCode: 'NDLS',
      fromName: 'New Delhi',
      toCode: 'BPL',
      toName: 'Bhopal',
      depH: 6,
      depM: 0,
      arrH: 14,
      arrM: 25,
      seats: 120,
      fare: 1680,
      coachClass: 'Chair Car (CC)',
    ),
    t(
      id: '5',
      name: 'Duronto Express',
      number: '12269',
      fromCode: 'HWH',
      fromName: 'Howrah',
      toCode: 'CST',
      toName: 'Mumbai CSMT',
      depH: 20,
      depM: 0,
      arrH: 0,
      arrM: 30,
      seats: 64,
      fare: 2890,
      coachClass: 'AC 3 Tier (3A)',
    ),
    t(
      id: '6',
      name: 'Garib Rath',
      number: '12910',
      fromCode: 'NDLS',
      fromName: 'New Delhi',
      toCode: 'BCT',
      toName: 'Mumbai Bandra',
      depH: 15,
      depM: 40,
      arrH: 12,
      arrM: 45,
      seats: 8,
      fare: 1895,
      coachClass: 'AC 3 Tier (3A)',
    ),
    t(
      id: '7',
      name: 'Cheran Express',
      number: '12674',
      fromCode: 'MAS',
      fromName: 'Chennai Central',
      toCode: 'CBE',
      toName: 'Coimbatore',
      depH: 6,
      depM: 0,
      arrH: 13,
      arrM: 0,
      seats: 210,
      fare: 485,
      coachClass: 'Sleeper (SL)',
    ),
    t(
      id: '8',
      name: 'Brindavan Express',
      number: '12640',
      fromCode: 'MAS',
      fromName: 'Chennai Central',
      toCode: 'SBC',
      toName: 'Bengaluru',
      depH: 7,
      depM: 40,
      arrH: 13,
      arrM: 40,
      seats: 340,
      fare: 365,
      coachClass: 'Second Sitting (2S)',
    ),
  ];
}
