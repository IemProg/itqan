import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/scoring/models/score_result.dart';
import 'package:itqan/core/theme/colors.dart';

ScoreResult _makeResult(double overall) => ScoreResult(
      overall: overall,
      wordAccuracy: overall,
      letterAccuracy: overall,
      tajweed: overall,
      fluency: overall,
      wordScores: const [],
      surahNumber: 1,
      ayahNumber: 1,
    );

void main() {
  group('ScoreResult.grade', () {
    test('95 → Excellent', () {
      expect(_makeResult(95).grade, equals('Excellent'));
    });

    test('90 → Excellent (boundary)', () {
      expect(_makeResult(90).grade, equals('Excellent'));
    });

    test('82 → Very Good', () {
      expect(_makeResult(82).grade, equals('Very Good'));
    });

    test('80 → Very Good (boundary)', () {
      expect(_makeResult(80).grade, equals('Very Good'));
    });

    test('72 → Good', () {
      expect(_makeResult(72).grade, equals('Good'));
    });

    test('70 → Good (boundary)', () {
      expect(_makeResult(70).grade, equals('Good'));
    });

    test('62 → Fair', () {
      expect(_makeResult(62).grade, equals('Fair'));
    });

    test('60 → Fair (boundary)', () {
      expect(_makeResult(60).grade, equals('Fair'));
    });

    test('45 → Needs Practice', () {
      expect(_makeResult(45).grade, equals('Needs Practice'));
    });

    test('0 → Needs Practice', () {
      expect(_makeResult(0).grade, equals('Needs Practice'));
    });
  });

  group('ScoreResult.color', () {
    test('90 → correct (green)', () {
      expect(_makeResult(90).color, equals(ItqanColors.correct));
    });

    test('85 → correct (boundary)', () {
      expect(_makeResult(85).color, equals(ItqanColors.correct));
    });

    test('75 → warning (gold)', () {
      expect(_makeResult(75).color, equals(ItqanColors.warning));
    });

    test('65 → warning (boundary)', () {
      expect(_makeResult(65).color, equals(ItqanColors.warning));
    });

    test('55 → error (red)', () {
      expect(_makeResult(55).color, equals(ItqanColors.error));
    });

    test('0 → error (red)', () {
      expect(_makeResult(0).color, equals(ItqanColors.error));
    });
  });

  group('WordScore', () {
    test('creates with required fields', () {
      const ws = WordScore(word: 'بِسْمِ', score: 0.85);
      expect(ws.word, equals('بِسْمِ'));
      expect(ws.score, equals(0.85));
      expect(ws.error, isNull);
    });

    test('creates with optional error field', () {
      const ws = WordScore(word: 'ٱللَّهِ', score: 0.6, error: 'Check tashkeel');
      expect(ws.error, equals('Check tashkeel'));
    });
  });
}
