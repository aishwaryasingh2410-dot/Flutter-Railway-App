import 'dart:math';

/// Generates a mock PNR-style code.
class PnrService {
  PnrService() : _random = Random();

  final Random _random;

  static const _chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  String next() {
    return List.generate(8, (_) => _chars[_random.nextInt(_chars.length)]).join();
  }
}
