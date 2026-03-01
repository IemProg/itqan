class Word {
  final int position;
  final String textUthmani;
  final String transliteration;

  const Word({
    required this.position,
    required this.textUthmani,
    required this.transliteration,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      position: json['position'] as int? ?? 0,
      textUthmani: json['text_uthmani'] as String? ?? '',
      transliteration: json['transliteration']?['text'] as String? ?? '',
    );
  }
}

class Ayah {
  final int surahNumber;
  final int ayahNumber;
  final String textUthmani;
  final List<Word> words;
  final String translation;

  const Ayah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.textUthmani,
    required this.words,
    required this.translation,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    final words = (json['words'] as List<dynamic>? ?? [])
        .map((w) => Word.fromJson(w as Map<String, dynamic>))
        .toList();

    String translation = '';
    final translations = json['translations'] as List<dynamic>?;
    if (translations != null && translations.isNotEmpty) {
      translation = translations.first['text'] as String? ?? '';
      // Strip HTML tags
      translation = translation.replaceAll(RegExp(r'<[^>]*>'), '');
    }

    return Ayah(
      surahNumber: json['chapter_id'] as int? ?? 0,
      ayahNumber: json['verse_number'] as int? ?? 0,
      textUthmani: json['text_uthmani'] as String? ?? '',
      words: words,
      translation: translation,
    );
  }

  String get audioUrl {
    final surahPadded = surahNumber.toString().padLeft(3, '0');
    final ayahPadded = ayahNumber.toString().padLeft(3, '0');
    return 'https://verses.quran.com/Alafasy/mp3/$surahPadded$ayahPadded.mp3';
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': surahNumber,
      'verse_number': ayahNumber,
      'text_uthmani': textUthmani,
      'words': words.map((w) => {
        'position': w.position,
        'text_uthmani': w.textUthmani,
        'transliteration': {'text': w.transliteration},
      }).toList(),
      'translations': [{'text': translation}],
    };
  }
}

class Surah {
  final int number;
  final String nameArabic;
  final String nameSimple;
  final String nameTranslation;
  final int ayahCount;
  final String revelationPlace;

  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameSimple,
    required this.nameTranslation,
    required this.ayahCount,
    required this.revelationPlace,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['id'] as int? ?? 0,
      nameArabic: json['name_arabic'] as String? ?? '',
      nameSimple: json['name_simple'] as String? ?? '',
      nameTranslation: json['translated_name']?['name'] as String? ?? '',
      ayahCount: json['verses_count'] as int? ?? 0,
      revelationPlace: json['revelation_place'] as String? ?? '',
    );
  }
}
