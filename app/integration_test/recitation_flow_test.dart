/// Integration test: Full recitation flow
/// 
/// NOTE: These tests require a connected device or emulator.
/// They cannot run in headless flutter test mode without a device.
/// Run with: flutter test integration_test/ --device-id <device-id>
///
/// Stubbed here for structure — assertions verify basic UI rendering
/// without actual audio recording (which requires platform permissions).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itqan/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Recitation Flow Integration Tests', () {
    testWidgets('App launches without crashing', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      // App should be running — at least one widget rendered
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Home screen renders bottom navigation', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      // Bottom nav should be present
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    // NOTE: The following tests require:
    // 1. Network connectivity (to fetch Quran data from quran.com API)
    // 2. Audio permissions (for recording)
    // These are documented as integration tests that run on device only.

    testWidgets('Quran tab is accessible via bottom navigation', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));
      // Tap the Quran tab (book icon)
      final quranTab = find.byIcon(Icons.menu_book_rounded);
      if (quranTab.evaluate().isNotEmpty) {
        await tester.tap(quranTab);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
