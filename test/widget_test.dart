import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patterns_setstate/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.byType(Center), findsOneWidget);

    expect(find.text("Detail Page"), findsOneWidget);
    expect(find.text("Details Page"), findsNothing);
  });
}
