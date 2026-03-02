import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/recitation/widgets/word_token.dart';
import 'package:itqan/features/quran/models/ayah.dart';
import 'package:itqan/core/theme/colors.dart';

const _testWord = Word(
  position: 1,
  textUthmani: 'بِسْمِ',
  transliteration: 'bismi',
);

void main() {
  group('WordToken', () {
    testWidgets('renders Arabic text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WordToken(word: _testWord)),
        ),
      );
      expect(find.text('بِسْمِ'), findsOneWidget);
    });

    testWidgets('renders in idle state without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord, state: WordState.idle),
          ),
        ),
      );
      expect(find.byType(WordToken), findsOneWidget);
    });

    testWidgets('renders in correct state with green color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord, state: WordState.correct),
          ),
        ),
      );
      // Find the Text widget and check its color
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.style?.color, equals(ItqanColors.correct));
    });

    testWidgets('renders in error state with red color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord, state: WordState.error),
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.style?.color, equals(ItqanColors.error));
    });

    testWidgets('renders in warning state with warning color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord, state: WordState.warning),
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.style?.color, equals(ItqanColors.warning));
    });

    testWidgets('renders in active state with gold color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord, state: WordState.active),
          ),
        ),
      );
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.style?.color, equals(ItqanColors.goldLight));
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WordToken(
              word: _testWord,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.byType(WordToken));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('does not crash when onTap is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WordToken(word: _testWord),
          ),
        ),
      );
      await tester.tap(find.byType(WordToken));
      await tester.pump();
      expect(find.byType(WordToken), findsOneWidget);
    });

    testWidgets('text uses RTL direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WordToken(word: _testWord)),
        ),
      );
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.textDirection, equals(TextDirection.rtl));
    });

    testWidgets('font family is NotoNaskhArabic', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: WordToken(word: _testWord)),
        ),
      );
      final text = tester.widget<Text>(find.text('بِسْمِ'));
      expect(text.style?.fontFamily, equals('NotoNaskhArabic'));
    });
  });
}
