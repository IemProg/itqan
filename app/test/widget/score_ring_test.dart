import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/shared/widgets/score_ring.dart';

void main() {
  group('ScoreRing Widget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 87)),
        ),
      );
      expect(find.byType(ScoreRing), findsOneWidget);
    });

    testWidgets('accepts score 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 0)),
        ),
      );
      expect(find.byType(ScoreRing), findsOneWidget);
    });

    testWidgets('accepts score 100', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 100)),
        ),
      );
      expect(find.byType(ScoreRing), findsOneWidget);
    });

    testWidgets('shows "out of 100" label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 75)),
        ),
      );
      expect(find.text('out of 100'), findsOneWidget);
    });

    testWidgets('shows score text after animation completes', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 75)),
        ),
      );
      // Run the animation to completion
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pump();
      // After animation, score should be ~75
      expect(find.text('75'), findsOneWidget);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ScoreRing(score: 50, size: 200)),
        ),
      );
      expect(find.byType(ScoreRing), findsOneWidget);
    });

    testWidgets('disposes cleanly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ScoreRing(score: 80))),
      );
      // Replace widget — triggers dispose
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(ScoreRing), findsNothing);
    });
  });
}
