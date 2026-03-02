import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSettings {
  final String userName;
  final String level;
  final int dailyGoalMinutes;
  final String quranicScript;
  final double fontSize;
  final bool tajweedOverlay;
  final String translationLanguage;
  final String defaultQari;
  final double playbackSpeed;
  final String scoringDifficulty;
  final String theme;
  final String language;
  final bool notifications;

  const AppSettings({
    this.userName = '',
    this.level = 'beginner',
    this.dailyGoalMinutes = 20,
    this.quranicScript = 'uthmani',
    this.fontSize = 28,
    this.tajweedOverlay = false,
    this.translationLanguage = 'english',
    this.defaultQari = 'alafasy',
    this.playbackSpeed = 1.0,
    this.scoringDifficulty = 'beginner',
    this.theme = 'dark',
    this.language = 'arabic',
    this.notifications = true,
  });

  AppSettings copyWith({
    String? userName,
    String? level,
    int? dailyGoalMinutes,
    String? quranicScript,
    double? fontSize,
    bool? tajweedOverlay,
    String? translationLanguage,
    String? defaultQari,
    double? playbackSpeed,
    String? scoringDifficulty,
    String? theme,
    String? language,
    bool? notifications,
  }) {
    return AppSettings(
      userName: userName ?? this.userName,
      level: level ?? this.level,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      quranicScript: quranicScript ?? this.quranicScript,
      fontSize: fontSize ?? this.fontSize,
      tajweedOverlay: tajweedOverlay ?? this.tajweedOverlay,
      translationLanguage: translationLanguage ?? this.translationLanguage,
      defaultQari: defaultQari ?? this.defaultQari,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      scoringDifficulty: scoringDifficulty ?? this.scoringDifficulty,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() => {
    'userName': userName, 'level': level,
    'dailyGoalMinutes': dailyGoalMinutes, 'quranicScript': quranicScript,
    'fontSize': fontSize, 'tajweedOverlay': tajweedOverlay,
    'translationLanguage': translationLanguage, 'defaultQari': defaultQari,
    'playbackSpeed': playbackSpeed, 'scoringDifficulty': scoringDifficulty,
    'theme': theme, 'language': language, 'notifications': notifications,
  };

  factory AppSettings.fromMap(Map map) => AppSettings(
    userName: map['userName'] ?? '',
    level: map['level'] ?? 'beginner',
    dailyGoalMinutes: map['dailyGoalMinutes'] ?? 20,
    quranicScript: map['quranicScript'] ?? 'uthmani',
    fontSize: (map['fontSize'] ?? 28).toDouble(),
    tajweedOverlay: map['tajweedOverlay'] ?? false,
    translationLanguage: map['translationLanguage'] ?? 'english',
    defaultQari: map['defaultQari'] ?? 'alafasy',
    playbackSpeed: (map['playbackSpeed'] ?? 1.0).toDouble(),
    scoringDifficulty: map['scoringDifficulty'] ?? 'beginner',
    theme: map['theme'] ?? 'dark',
    language: map['language'] ?? 'arabic',
    notifications: map['notifications'] ?? true,
  );
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings()) { _load(); }

  Future<void> _load() async {
    final box = Hive.box('settings');
    final data = box.get('prefs');
    if (data != null) state = AppSettings.fromMap(Map<String, dynamic>.from(data as Map));
  }

  Future<void> update(AppSettings s) async {
    state = s;
    await Hive.box('settings').put('prefs', s.toMap());
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(),
);

class UserPreferences {
  final int lastSurah;
  final int lastAyah;
  const UserPreferences({this.lastSurah = 1, this.lastAyah = 1});
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(const UserPreferences()) { _load(); }

  Future<void> _load() async {
    final box = Hive.box('settings');
    state = UserPreferences(
      lastSurah: box.get('lastSurah', defaultValue: 1) as int,
      lastAyah: box.get('lastAyah', defaultValue: 1) as int,
    );
  }

  Future<void> saveLastPracticed(int surah, int ayah) async {
    state = UserPreferences(lastSurah: surah, lastAyah: ayah);
    final box = Hive.box('settings');
    await box.put('lastSurah', surah);
    await box.put('lastAyah', ayah);
  }
}

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  (ref) => UserPreferencesNotifier(),
);
