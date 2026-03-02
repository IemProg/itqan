import 'package:flutter_test/flutter_test.dart';
import 'package:itqan/features/settings/settings_service.dart';

void main() {
  group('AppSettings defaults', () {
    const settings = AppSettings();

    test('default level is beginner', () {
      expect(settings.level, equals('beginner'));
    });

    test('default fontSize is 28', () {
      expect(settings.fontSize, equals(28.0));
    });

    test('default scoringDifficulty is beginner', () {
      expect(settings.scoringDifficulty, equals('beginner'));
    });

    test('default theme is dark', () {
      expect(settings.theme, equals('dark'));
    });

    test('default language is arabic', () {
      expect(settings.language, equals('arabic'));
    });

    test('default qari is alafasy', () {
      expect(settings.defaultQari, equals('alafasy'));
    });

    test('default playbackSpeed is 1.0', () {
      expect(settings.playbackSpeed, equals(1.0));
    });

    test('default dailyGoalMinutes is 20', () {
      expect(settings.dailyGoalMinutes, equals(20));
    });

    test('default tajweedOverlay is false', () {
      expect(settings.tajweedOverlay, isFalse);
    });

    test('default notifications is true', () {
      expect(settings.notifications, isTrue);
    });
  });

  group('AppSettings.copyWith', () {
    test('can update level', () {
      const original = AppSettings();
      final updated = original.copyWith(level: 'advanced');
      expect(updated.level, equals('advanced'));
      expect(updated.fontSize, equals(28.0)); // unchanged
    });

    test('can update fontSize', () {
      const original = AppSettings();
      final updated = original.copyWith(fontSize: 32.0);
      expect(updated.fontSize, equals(32.0));
      expect(updated.level, equals('beginner')); // unchanged
    });

    test('can update multiple fields', () {
      const original = AppSettings();
      final updated = original.copyWith(
        level: 'intermediate',
        scoringDifficulty: 'intermediate',
        tajweedOverlay: true,
      );
      expect(updated.level, equals('intermediate'));
      expect(updated.scoringDifficulty, equals('intermediate'));
      expect(updated.tajweedOverlay, isTrue);
      expect(updated.theme, equals('dark')); // unchanged
    });

    test('copyWith preserves all defaults when called with no args', () {
      const original = AppSettings();
      final copied = original.copyWith();
      expect(copied.level, equals(original.level));
      expect(copied.fontSize, equals(original.fontSize));
      expect(copied.theme, equals(original.theme));
    });
  });

  group('AppSettings serialization (toMap / fromMap)', () {
    test('round-trips via toMap/fromMap', () {
      const original = AppSettings(
        userName: 'Ahmed',
        level: 'intermediate',
        fontSize: 30.0,
        tajweedOverlay: true,
        defaultQari: 'husary',
      );
      final map = original.toMap();
      final restored = AppSettings.fromMap(map);

      expect(restored.userName, equals('Ahmed'));
      expect(restored.level, equals('intermediate'));
      expect(restored.fontSize, equals(30.0));
      expect(restored.tajweedOverlay, isTrue);
      expect(restored.defaultQari, equals('husary'));
    });

    test('fromMap falls back to defaults for missing keys', () {
      final settings = AppSettings.fromMap({});
      expect(settings.level, equals('beginner'));
      expect(settings.fontSize, equals(28.0));
    });
  });

  group('Scoring weights concept (documented in spec)', () {
    // Beginner: word 0.40, phoneme 0.25, tashkeel 0.15, tajweed 0.10, fluency 0.10
    test('beginner weights sum to 1.0', () {
      const beginner = [0.40, 0.25, 0.15, 0.10, 0.10];
      final sum = beginner.fold<double>(0, (a, b) => a + b);
      expect(sum, closeTo(1.0, 0.001));
    });

    // Intermediate: 0.25, 0.25, 0.20, 0.20, 0.10
    test('intermediate weights sum to 1.0', () {
      const intermediate = [0.25, 0.25, 0.20, 0.20, 0.10];
      final sum = intermediate.fold<double>(0, (a, b) => a + b);
      expect(sum, closeTo(1.0, 0.001));
    });

    // Advanced: 0.15, 0.25, 0.20, 0.30, 0.10
    test('advanced weights sum to 1.0', () {
      const advanced = [0.15, 0.25, 0.20, 0.30, 0.10];
      final sum = advanced.fold<double>(0, (a, b) => a + b);
      expect(sum, closeTo(1.0, 0.001));
    });
  });
}
