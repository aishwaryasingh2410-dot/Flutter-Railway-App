import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:railway_booking/app.dart';

void main() {
  testWidgets('FYP home and chrome load', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RailwayApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('FinalYearProject'), findsOneWidget);
    expect(find.text('Ticket Booking'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
