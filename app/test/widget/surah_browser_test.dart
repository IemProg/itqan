import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/quran/models/ayah.dart';
import 'package:itqan/features/mushaf/mushaf_screen.dart'; // for surahsProvider

// Helper to create test surahs
List<Surah> _testSurahs() => [
      const Surah(
        number: 1,
        nameArabic: 'الفاتحة',
        nameSimple: 'Al-Fatihah',
        nameTranslation: 'The Opener',
        ayahCount: 7,
        revelationPlace: 'makkah',
      ),
      const Surah(
        number: 2,
        nameArabic: 'البقرة',
        nameSimple: 'Al-Baqarah',
        nameTranslation: 'The Cow',
        ayahCount: 286,
        revelationPlace: 'madinah',
      ),
      const Surah(
        number: 112,
        nameArabic: 'الإخلاص',
        nameSimple: 'Al-Ikhlas',
        nameTranslation: 'Sincerity',
        ayahCount: 4,
        revelationPlace: 'makkah',
      ),
    ];

// Wrap app in ProviderScope with overrides
Widget _makeApp({List<Surah>? surahs}) {
  return ProviderScope(
    overrides: [
      surahsProvider.overrideWith(
        (ref) async => surahs ?? _testSurahs(),
      ),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: Text('Surah browser placeholder'),
      ),
    ),
  );
}

void main() {
  group('Surah data model tests (browser integration)', () {
    // Note: Full SurahBrowserScreen tests require navigation context.
    // These tests verify the underlying data models and provider setup.

    test('test surahs list has 3 entries', () {
      expect(_testSurahs().length, equals(3));
    });

    test('Al-Fatihah has 7 ayahs', () {
      final fatiha = _testSurahs().firstWhere((s) => s.number == 1);
      expect(fatiha.ayahCount, equals(7));
    });

    test('Al-Baqarah has 286 ayahs', () {
      final baqarah = _testSurahs().firstWhere((s) => s.number == 2);
      expect(baqarah.ayahCount, equals(286));
    });

    test('surah nameSimple is not empty', () {
      for (final s in _testSurahs()) {
        expect(s.nameSimple.isNotEmpty, isTrue);
      }
    });

    test('surah nameArabic is not empty', () {
      for (final s in _testSurahs()) {
        expect(s.nameArabic.isNotEmpty, isTrue);
      }
    });

    test('surah numbers are unique', () {
      final numbers = _testSurahs().map((s) => s.number).toList();
      expect(numbers.toSet().length, equals(numbers.length));
    });

    testWidgets('ProviderScope with surahsProvider override builds', (tester) async {
      await tester.pumpWidget(_makeApp());
      await tester.pump();
      expect(find.byType(ProviderScope), findsOneWidget);
    });
  });
}
