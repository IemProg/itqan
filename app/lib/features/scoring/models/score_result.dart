import 'package:flutter/material.dart';

class WordScore {
  final String word;
  final double score; // 0-1
  final String? error;

  const WordScore({
    required this.word,
    required this.score,
    this.error,
  });
}

class ScoreResult {
  final double overall;
  final double wordAccuracy;
  final double letterAccuracy;
  final double tajweed;
  final double fluency;
  final List<WordScore> wordScores;
  final int surahNumber;
  final int ayahNumber;

  const ScoreResult({
    required this.overall,
    required this.wordAccuracy,
    required this.letterAccuracy,
    required this.tajweed,
    required this.fluency,
    required this.wordScores,
    required this.surahNumber,
    required this.ayahNumber,
  });

  Color get color {
    if (overall >= 85) return const Color(0xFF34D399);
    if (overall >= 65) return const Color(0xFFFBBF24);
    return const Color(0xFFF87171);
  }

  String get grade {
    if (overall >= 90) return 'Excellent';
    if (overall >= 80) return 'Very Good';
    if (overall >= 70) return 'Good';
    if (overall >= 60) return 'Fair';
    return 'Needs Practice';
  }
}
