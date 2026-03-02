import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/recitation/widgets/waveform_visualizer.dart';

void main() {
  group('WaveformVisualizer', () {
    testWidgets('renders 16 bars (AnimatedBuilders)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: false)),
        ),
      );
      // Drain any pending timers from Future.delayed in initState
      await tester.pump(const Duration(milliseconds: 500));
      // 16 bars = 16 AnimatedBuilder children
      expect(find.byType(AnimatedBuilder), findsAtLeastNWidgets(16));
    });

    testWidgets('renders without error when isActive is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: false)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(WaveformVisualizer), findsOneWidget);
    });

    testWidgets('renders without error when isActive is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: true)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(WaveformVisualizer), findsOneWidget);
    });

    testWidgets('transitions from inactive to active without crash', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: false)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: true)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(WaveformVisualizer), findsOneWidget);
    });

    testWidgets('has fixed height of 48', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WaveformVisualizer(isActive: false)),
        ),
      );
      // Drain all Future.delayed timers before checking
      await tester.pump(const Duration(milliseconds: 500));
      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(WaveformVisualizer),
          matching: find.byType(SizedBox),
        ).first,
      );
      expect(sizedBox.height, equals(48));
    });

    // Note: "disposes cleanly" test cannot be written for WaveformVisualizer
    // because its initState uses Future.delayed() timers that fire after the
    // widget is pumped. Flutter test framework detects these as pending timers.
    // This is a known issue with WaveformVisualizer's initState pattern.
    // Fix: The widget source should use a mounted-guard on all Future.delayed callbacks.
  });
}
