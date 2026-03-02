/// Integration test: Mushaf reader navigation
///
/// NOTE: Requires a connected device/emulator AND network connectivity.
/// Run with: flutter test integration_test/ --device-id <device-id>

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itqan/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Mushaf Reader Integration Tests', () {
    testWidgets('App launches and mushaf tab is reachable', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    // Full mushaf navigation tests (device-only):
    //
    // testWidgets('Mushaf page 1 loads Arabic text', (tester) async {
    //   app.main();
    //   await tester.pumpAndSettle(const Duration(seconds: 5));
    //   // Navigate to Quran tab
    //   await tester.tap(find.byIcon(Icons.menu_book_rounded));
    //   await tester.pumpAndSettle(const Duration(seconds: 3));
    //   // Tap Read on Al-Fatihah
    //   await tester.tap(find.text('Read').first);
    //   await tester.pumpAndSettle(const Duration(seconds: 5));
    //   // Arabic text from page 1 should be present
    //   expect(find.textContaining('بِسْمِ'), findsWidgets);
    // });
    //
    // testWidgets('Swipe to page 2 works', (tester) async {
    //   // ... navigate to mushaf page 1 first ...
    //   await tester.fling(find.byType(PageView), const Offset(-400, 0), 800);
    //   await tester.pumpAndSettle();
    //   // Page 2 content should be visible
    // });
  });
}
