/// Mumbai suburban demo fare: second-class single = ₹20 per adult (reference UI).
abstract final class TicketFareCalculator {
  static const int secondClassSinglePerPerson = 20;

  /// Second-class total before first-class multiplier.
  /// Single: 20 × persons. Return: 40 × persons.
  static int secondClassTotal({
    required bool isReturn,
    required int passengers,
  }) {
    final perPerson = isReturn
        ? secondClassSinglePerPerson * 2
        : secondClassSinglePerPerson;
    return perPerson * passengers;
  }

  /// First class doubles the second-class amount for the same journey & count.
  static int totalRupees({
    required bool isReturn,
    required int passengers,
    required bool firstClass,
  }) {
    final second = secondClassTotal(isReturn: isReturn, passengers: passengers);
    return firstClass ? second * 2 : second;
  }
}
