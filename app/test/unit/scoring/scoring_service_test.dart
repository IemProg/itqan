import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/scoring/scoring_service.dart';
import 'package:itqan/features/quran/models/ayah.dart';

void main() {
  group('ScoringService', () {
    late ScoringService service;
    late Ayah testAyah;

    setUp(() {
      service = ScoringService();
      testAyah = const Ayah(
        surahNumber: 1,
        ayahNumber: 1,
        textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
        words: [
          Word(position: 1, textUthmani: 'بِسْمِ', transliteration: 'bismi'),
          Word(position: 2, textUthmani: 'ٱللَّهِ', transliteration: 'allahi'),
          Word(position: 3, textUthmani: 'ٱلرَّحْمَـٰنِ', transliteration: 'alrrahmani'),
          Word(position: 4, textUthmani: 'ٱلرَّحِيمِ', transliteration: 'alrraheemi'),
        ],
        translation:
            'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
      );
    });

    test('scoreRecording returns a ScoreResult', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      expect(result, isNotNull);
    });

    test('overall score is between 0 and 100', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      expect(result.overall, greaterThanOrEqualTo(0));
      expect(result.overall, lessThanOrEqualTo(100));
    });

    test('word scores count matches ayah word count', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      expect(result.wordScores.length, equals(testAyah.words.length));
    });

    test('word scores are between 0.0 and 1.0', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      for (final ws in result.wordScores) {
        expect(ws.score, greaterThanOrEqualTo(0.0));
        expect(ws.score, lessThanOrEqualTo(1.0));
      }
    });

    test('result contains correct surah and ayah numbers', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      expect(result.surahNumber, equals(1));
      expect(result.ayahNumber, equals(1));
    });

    test('sub-scores are between 0 and 100', () async {
      final result = await service.scoreRecording(
        audioPath: 'test_audio.m4a',
        ayah: testAyah,
      );
      for (final score in [
        result.wordAccuracy,
        result.letterAccuracy,
        result.tajweed,
        result.fluency,
      ]) {
        expect(score, greaterThanOrEqualTo(0));
        expect(score, lessThanOrEqualTo(100));
      }
    });

    test('scoring multiple ayahs returns independent results', () async {
      final ayah2 = const Ayah(
        surahNumber: 1,
        ayahNumber: 2,
        textUthmani: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ',
        words: [
          Word(position: 1, textUthmani: 'ٱلْحَمْدُ', transliteration: 'alhamdu'),
          Word(position: 2, textUthmani: 'لِلَّهِ', transliteration: 'lillahi'),
          Word(position: 3, textUthmani: 'رَبِّ', transliteration: 'rabbi'),
          Word(position: 4, textUthmani: 'ٱلْعَـٰلَمِينَ', transliteration: 'alAAalameen'),
        ],
        translation: 'All praise is due to Allah, Lord of the worlds.',
      );
      final r1 = await service.scoreRecording(
        audioPath: 'audio1.m4a',
        ayah: testAyah,
      );
      final r2 = await service.scoreRecording(
        audioPath: 'audio2.m4a',
        ayah: ayah2,
      );
      expect(r1.wordScores.length, equals(4));
      expect(r2.wordScores.length, equals(4));
      expect(r1.ayahNumber, equals(1));
      expect(r2.ayahNumber, equals(2));
    });
  });
}
