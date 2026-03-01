import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/ayah.dart';

class QuranService {
  static const String _baseUrl = 'https://api.quran.com/api/v4';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  late Box _cacheBox;

  Future<void> init() async {
    _cacheBox = await Hive.openBox('quran_cache');
  }

  Future<List<Surah>> getSurahs() async {
    const cacheKey = 'surahs';
    final cached = _cacheBox.get(cacheKey);
    if (cached != null) {
      final List<dynamic> list = jsonDecode(cached as String);
      return list.map((j) => Surah.fromJson(j as Map<String, dynamic>)).toList();
    }

    final response = await _dio.get('/chapters?language=en');
    final chapters = response.data['chapters'] as List<dynamic>;
    final surahs = chapters.map((j) => Surah.fromJson(j as Map<String, dynamic>)).toList();

    await _cacheBox.put(cacheKey, jsonEncode(chapters));
    return surahs;
  }

  Future<List<Ayah>> getAyahs(int surahNumber) async {
    final cacheKey = 'ayahs_$surahNumber';
    final cached = _cacheBox.get(cacheKey);
    if (cached != null) {
      final List<dynamic> list = jsonDecode(cached as String);
      return list.map((j) => Ayah.fromJson(j as Map<String, dynamic>)).toList();
    }

    final response = await _dio.get(
      '/verses/by_chapter/$surahNumber',
      queryParameters: {
        'words': 'true',
        'translations': '131',
        'word_fields': 'text_uthmani,transliteration',
        'per_page': '300',
      },
    );

    final verses = response.data['verses'] as List<dynamic>;
    final ayahs = verses.map((j) => Ayah.fromJson(j as Map<String, dynamic>)).toList();

    await _cacheBox.put(cacheKey, jsonEncode(verses));
    return ayahs;
  }
}
