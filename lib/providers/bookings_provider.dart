import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/booking.dart';
import '../models/train.dart';
import '../services/pnr_service.dart';
import 'pnr_service_provider.dart';
import 'train_service_provider.dart';

class BookingsNotifier extends StateNotifier<List<Booking>> {
  BookingsNotifier(this._ref) : super(_initial(_ref)) {
    _pnr = _ref.read(pnrServiceProvider);
  }

  final Ref _ref;
  late final PnrService _pnr;

  static List<Booking> _initial(Ref ref) {
    final trains = ref.read(trainServiceProvider).all;
    final now = DateTime.now();
    final t1 = trains.firstWhere((e) => e.id == '1');
    final t2 = trains.firstWhere((e) => e.id == '7');
    return [
      Booking(
        id: 'b1',
        pnr: 'Z8KQ2M7P',
        train: t1,
        journeyDate: DateTime(now.year, now.month, now.day).add(const Duration(days: 3)),
        passengerName: 'Mahi Kumar',
        status: BookingStatus.confirmed,
        bookedAt: now.subtract(const Duration(days: 2)),
      ),
      Booking(
        id: 'b2',
        pnr: '4NH9PL2W',
        train: t2,
        journeyDate: DateTime(now.year, now.month, now.day).add(const Duration(days: 10)),
        passengerName: 'Mahi Kumar',
        status: BookingStatus.confirmed,
        bookedAt: now.subtract(const Duration(hours: 5)),
      ),
    ];
  }

  void addBooking({
    required Train train,
    required String passengerName,
    required DateTime journeyDate,
  }) {
    final booking = Booking(
      id: 'b${DateTime.now().microsecondsSinceEpoch}',
      pnr: _pnr.next(),
      train: train,
      journeyDate: journeyDate,
      passengerName: passengerName,
      status: BookingStatus.confirmed,
      bookedAt: DateTime.now(),
    );
    state = [booking, ...state];
  }

  void cancel(String bookingId) {
    state = [
      for (final b in state)
        if (b.id == bookingId)
          Booking(
            id: b.id,
            pnr: b.pnr,
            train: b.train,
            journeyDate: b.journeyDate,
            passengerName: b.passengerName,
            status: BookingStatus.cancelled,
            bookedAt: b.bookedAt,
          )
        else
          b,
    ];
  }
}

final bookingsProvider =
    StateNotifierProvider<BookingsNotifier, List<Booking>>((ref) {
  return BookingsNotifier(ref);
});
