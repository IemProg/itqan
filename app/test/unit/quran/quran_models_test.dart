import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/quran/models/ayah.dart';

void main() {
  group('Word model', () {
    test('constructs correctly', () {
      const word = Word(
        position: 1,
        textUthmani: 'بِسْمِ',
        transliteration: 'bismi',
      );
      expect(word.position, equals(1));
      expect(word.textUthmani, equals('بِسْمِ'));
      expect(word.transliteration, equals('bismi'));
    });

    test('fromJson parses correctly', () {
      final json = {
        'position': 2,
        'text_uthmani': 'ٱللَّهِ',
        'transliteration': {'text': 'allahi'},
      };
      final word = Word.fromJson(json);
      expect(word.position, equals(2));
      expect(word.textUthmani, equals('ٱللَّهِ'));
      expect(word.transliteration, equals('allahi'));
    });

    test('fromJson handles missing fields gracefully', () {
      final word = Word.fromJson({});
      expect(word.position, equals(0));
      expect(word.textUthmani, equals(''));
      expect(word.transliteration, equals(''));
    });
  });

  group('Ayah model', () {
    const testAyah = Ayah(
      surahNumber: 1,
      ayahNumber: 1,
      textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      words: [
        Word(position: 1, textUthmani: 'بِسْمِ', transliteration: 'bismi'),
        Word(position: 2, textUthmani: 'ٱللَّهِ', transliteration: 'allahi'),
      ],
      translation: 'In the name of Allah...',
    );

    test('constructs correctly', () {
      expect(testAyah.surahNumber, equals(1));
      expect(testAyah.ayahNumber, equals(1));
      expect(testAyah.words.length, equals(2));
    });

    test('audioUrl returns correct format', () {
      expect(testAyah.audioUrl,
          equals('https://verses.quran.com/Alafasy/mp3/001001.mp3'));
    });

    test('audioUrl pads surah and ayah to 3 digits', () {
      const ayah = Ayah(
        surahNumber: 2,
        ayahNumber: 255,
        textUthmani: '',
        words: [],
        translation: '',
      );
      expect(ayah.audioUrl,
          equals('https://verses.quran.com/Alafasy/mp3/002255.mp3'));
    });

    test('fromJson parses correctly', () {
      final json = {
        'chapter_id': 1,
        'verse_number': 1,
        'text_uthmani': 'بِسْمِ ٱللَّهِ',
        'words': [
          {
            'position': 1,
            'text_uthmani': 'بِسْمِ',
            'transliteration': {'text': 'bismi'},
          }
        ],
        'translations': [
          {'text': 'In the name of Allah'}
        ],
      };
      final ayah = Ayah.fromJson(json);
      expect(ayah.surahNumber, equals(1));
      expect(ayah.ayahNumber, equals(1));
      expect(ayah.words.length, equals(1));
      expect(ayah.translation, equals('In the name of Allah'));
    });

    test('fromJson strips HTML tags from translation', () {
      final json = {
        'chapter_id': 1,
        'verse_number': 1,
        'text_uthmani': '',
        'words': [],
        'translations': [
          {'text': '<p>In the name of <b>Allah</b></p>'}
        ],
      };
      final ayah = Ayah.fromJson(json);
      expect(ayah.translation, equals('In the name of Allah'));
    });

    test('toJson round-trips correctly', () {
      final json = testAyah.toJson();
      final restored = Ayah.fromJson(json);
      expect(restored.surahNumber, equals(testAyah.surahNumber));
      expect(restored.ayahNumber, equals(testAyah.ayahNumber));
      expect(restored.words.length, equals(testAyah.words.length));
    });
  });

  group('Surah model', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 1,
        'name_arabic': 'الفاتحة',
        'name_simple': 'Al-Fatihah',
        'translated_name': {'name': 'The Opener'},
        'verses_count': 7,
        'revelation_place': 'makkah',
      };
      final surah = Surah.fromJson(json);
      expect(surah.number, equals(1));
      expect(surah.nameArabic, equals('الفاتحة'));
      expect(surah.nameSimple, equals('Al-Fatihah'));
      expect(surah.nameTranslation, equals('The Opener'));
      expect(surah.ayahCount, equals(7));
      expect(surah.revelationPlace, equals('makkah'));
    });

    test('fromJson handles missing fields gracefully', () {
      final surah = Surah.fromJson({});
      expect(surah.number, equals(0));
      expect(surah.nameArabic, equals(''));
    });
  });
}
