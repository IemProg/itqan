import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/recitation/widgets/record_button.dart';

void main() {
  group('RecordButton', () {
    testWidgets('shows mic icon in idle state', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(
            state: RecordButtonState.idle,
            onTap: () {},
          ),
        ),
      ));
      expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
    });

    testWidgets('shows stop icon in recording state', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(
            state: RecordButtonState.recording,
            onTap: () {},
          ),
        ),
      ));
      expect(find.byIcon(Icons.stop_rounded), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator in processing state', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(
            state: RecordButtonState.processing,
            onTap: () {},
          ),
        ),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('calls onTap when tapped in idle state', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(
            state: RecordButtonState.idle,
            onTap: () => tapped = true,
          ),
        ),
      ));
      await tester.tap(find.byType(RecordButton));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('calls onTap when tapped in recording state', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(
            state: RecordButtonState.recording,
            onTap: () => tapped = true,
          ),
        ),
      ));
      await tester.tap(find.byType(RecordButton));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('renders without error in all states', (tester) async {
      for (final state in RecordButtonState.values) {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: RecordButton(state: state, onTap: () {}),
          ),
        ));
        expect(find.byType(RecordButton), findsOneWidget,
            reason: 'RecordButton should render in $state state');
        await tester.pump();
      }
    });

    testWidgets('disposes animation controllers cleanly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordButton(state: RecordButtonState.recording, onTap: () {}),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));
      // Replace widget to trigger dispose
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      expect(find.byType(RecordButton), findsNothing);
    });
  });
}
