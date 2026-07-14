// This is a basic Flutter widget test for the QuoteFlow app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quoteflow/main.dart';
import 'package:quoteflow/screens/about_screen.dart';

void main() {
  testWidgets('Splash screen rendering test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that Splash Screen elements are rendered.
    expect(find.text('Random Quote Generator'), findsOneWidget);
    expect(find.text('Daily Dose of Inspiration'), findsOneWidget);

    // Let the transition timer finish and dispose the splash screen.
    await tester.pump(const Duration(milliseconds: 3300));
    await tester.pump(const Duration(milliseconds: 800));
  });

  testWidgets('About Screen renders GitHub button', (WidgetTester tester) async {
    // Build the AboutScreen in a MaterialApp wrapper
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );

    // Verify that About Screen title is present
    expect(find.text('About QuoteFlow'), findsOneWidget);

    // Verify that the View on GitHub button is present
    expect(find.text('View on GitHub'), findsOneWidget);
    expect(find.byIcon(Icons.code_rounded), findsOneWidget);
  });
}
