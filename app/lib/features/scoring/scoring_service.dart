import 'dart:math';
import '../quran/models/ayah.dart';
import 'models/score_result.dart';

class ScoringService {
  final Random _random = Random();

  /// MVP placeholder scoring — simulates a real scoring engine.
  /// Word scores are randomized around a mean for realistic UI testing.
  /// Replace with Whisper/Tarteel integration in Phase 2.
  Future<ScoreResult> scoreRecording({
    required String audioPath,
    required Ayah ayah,
  }) async {
    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Generate plausible scores
    final baseScore = 70 + _random.nextDouble() * 25; // 70-95
    final wordAccuracy = (baseScore + _random.nextDouble() * 10 - 5).clamp(0, 100);
    final letterAccuracy = (baseScore - 5 + _random.nextDouble() * 10).clamp(0, 100);
    final tajweed = (baseScore - 10 + _random.nextDouble() * 15).clamp(0, 100);
    final fluency = (baseScore + 5 + _random.nextDouble() * 8 - 4).clamp(0, 100);

    final overall = (wordAccuracy * 0.25 + letterAccuracy * 0.25 + tajweed * 0.25 + fluency * 0.25);

    // Generate per-word scores
    final wordScores = ayah.words.map((w) {
      final score = (_random.nextDouble() * 0.4 + 0.6); // 0.6-1.0
      String? error;
      if (score < 0.75) {
        final errors = ['Pronunciation unclear', 'Check tashkeel', 'Tajweed rule missed'];
        error = errors[_random.nextInt(errors.length)];
      }
      return WordScore(word: w.textUthmani, score: score, error: error);
    }).toList();

    return ScoreResult(
      overall: overall,
      wordAccuracy: wordAccuracy.toDouble(),
      letterAccuracy: letterAccuracy.toDouble(),
      tajweed: tajweed.toDouble(),
      fluency: fluency.toDouble(),
      wordScores: wordScores,
      surahNumber: ayah.surahNumber,
      ayahNumber: ayah.ayahNumber,
    );
  }
}
