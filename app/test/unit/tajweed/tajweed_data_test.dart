import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/tajweed/tajweed_data.dart';
import 'package:itqan/core/theme/colors.dart';

void main() {
  group('TajweedAnnotations', () {
    test('Al-Fatiha annotations exist (at least 5 entries)', () {
      final fatihaAnnotations = tajweedAnnotations.keys
          .where((k) => k.startsWith('1:'))
          .toList();
      expect(fatihaAnnotations.length, greaterThanOrEqualTo(5));
    });

    test('Al-Ikhlas annotations exist', () {
      final ikhlas = tajweedAnnotations.keys
          .where((k) => k.startsWith('112:'))
          .toList();
      expect(ikhlas.length, greaterThan(0));
    });

    test('annotation keys have correct format surah:ayah:word', () {
      for (final key in tajweedAnnotations.keys) {
        final parts = key.split(':');
        expect(parts.length, equals(3),
            reason: 'Key "$key" should have format surah:ayah:wordIndex');
        expect(int.tryParse(parts[0]), isNotNull);
        expect(int.tryParse(parts[1]), isNotNull);
        expect(int.tryParse(parts[2]), isNotNull);
      }
    });

    test('annotation values are non-empty strings', () {
      for (final value in tajweedAnnotations.values) {
        expect(value.isNotEmpty, isTrue);
      }
    });
  });

  group('tajweedColor', () {
    test('returns non-null color for all known rules', () {
      final rules = [
        'idgham',
        'ikhfa',
        'iqlab',
        'izhar',
        'madd',
        'qalqalah',
        'ghunnah',
        'bismillah',
      ];
      for (final rule in rules) {
        expect(tajweedColor(rule), isNotNull,
            reason: 'tajweedColor("$rule") should not be null');
      }
    });

    test('idgham returns correct color', () {
      expect(tajweedColor('idgham'), equals(ItqanColors.tajweedIdgham));
    });

    test('ikhfa returns correct color', () {
      expect(tajweedColor('ikhfa'), equals(ItqanColors.tajweedIkhfa));
    });

    test('madd returns correct color', () {
      expect(tajweedColor('madd'), equals(ItqanColors.tajweedMadd));
    });

    test('qalqalah returns correct color', () {
      expect(tajweedColor('qalqalah'), equals(ItqanColors.tajweedQalqalah));
    });

    test('ghunnah returns correct color', () {
      expect(tajweedColor('ghunnah'), equals(ItqanColors.tajweedGhunnah));
    });

    test('unknown rule returns default color (does not throw)', () {
      expect(() => tajweedColor('unknown_rule'), returnsNormally);
      final color = tajweedColor('unknown_rule');
      expect(color, isNotNull);
    });

    test('empty string does not throw', () {
      expect(() => tajweedColor(''), returnsNormally);
    });
  });

  group('tajweedRuleName', () {
    test('returns human-readable names for known rules', () {
      expect(tajweedRuleName('idgham'), contains('Idgham'));
      expect(tajweedRuleName('madd'), contains('Madd'));
      expect(tajweedRuleName('qalqalah'), contains('Qalqalah'));
    });

    test('unknown rule returns the rule string itself', () {
      expect(tajweedRuleName('some_rule'), equals('some_rule'));
    });
  });

  group('tajweedExplanation', () {
    test('returns non-empty explanation for known rules', () {
      for (final rule in ['idgham', 'ikhfa', 'madd', 'qalqalah', 'ghunnah']) {
        expect(tajweedExplanation(rule).isNotEmpty, isTrue,
            reason: 'Rule "$rule" should have an explanation');
      }
    });

    test('unknown rule does not throw', () {
      expect(() => tajweedExplanation('unknown'), returnsNormally);
    });
  });
}
