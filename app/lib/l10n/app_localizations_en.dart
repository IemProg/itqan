// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Itqan';

  @override
  String get navHome => 'Home';

  @override
  String get navQuran => 'Quran';

  @override
  String get navProgress => 'Progress';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeGreeting => 'Assalamu Alaikum';

  @override
  String get homeSubtitle => 'Welcome to Itqan';

  @override
  String get homeContinueReading => 'Continue Reading';

  @override
  String get homeStartReading => 'Start with Al-Fatihah';

  @override
  String get homeContinueBtn => 'Continue →';

  @override
  String get homeStartFromBeginning => 'Start from ١';

  @override
  String get homeLastRead => 'Last Read';

  @override
  String get homePracticeMode => 'Practice';

  @override
  String get homeReadMode => 'Read';

  @override
  String get homeListenMode => 'Listen';

  @override
  String get homeProgressMode => 'Progress';

  @override
  String get quranTitle => 'The Holy Quran';

  @override
  String get quranSurahsTab => 'Surahs';

  @override
  String get quranJuzTab => 'Juz';

  @override
  String get quranSearchHint => 'Search surah...';

  @override
  String quranAyahCount(int count) {
    return '$count ayahs';
  }

  @override
  String get quranMakki => 'Makkah';

  @override
  String get quranMadani => 'Madinah';

  @override
  String quranJuzLabel(int number) {
    return 'Juz $number';
  }

  @override
  String get quranReadBtn => 'Read';

  @override
  String get quranPracticeBtn => 'Practice';

  @override
  String mushafPage(int page) {
    return 'Page $page';
  }

  @override
  String mushafJuz(int number) {
    return 'Juz $number';
  }

  @override
  String get mushafBookmarkSaved => 'Bookmark saved ✓';

  @override
  String get mushafBookmarkRemoved => 'Bookmark removed';

  @override
  String get mushafJumpToPage => 'Jump to page';

  @override
  String get mushafJumpConfirm => 'Go';

  @override
  String get mushafJumpCancel => 'Cancel';

  @override
  String get mushafTranslationToggle => 'Translation';

  @override
  String get mushafTajweedToggle => 'Tajweed';

  @override
  String get recitationTitle => 'Recitation';

  @override
  String get recitationListenFirst => 'Listen First';

  @override
  String get recitationRecord => 'Record';

  @override
  String get recitationStop => 'Stop';

  @override
  String get recitationRetry => 'Retry';

  @override
  String get recitationNextAyah => 'Next Ayah →';

  @override
  String get recitationRecording => 'Recording';

  @override
  String get recitationProcessing => 'Analysing...';

  @override
  String get resultsTitle => 'Results';

  @override
  String get resultsOverallScore => 'Overall Score';

  @override
  String get resultsWordAccuracy => 'Word Accuracy';

  @override
  String get resultsLetterAccuracy => 'Letter Accuracy';

  @override
  String get resultsTajweed => 'Tajweed';

  @override
  String get resultsFluency => 'Fluency';

  @override
  String get resultsExcellent => 'Excellent! Ma sha Allah';

  @override
  String get resultsGood => 'Good progress! Keep going';

  @override
  String get resultsNeedsWork => 'Let\'s work on this together';

  @override
  String get resultsMistakeCards => 'Mistakes';

  @override
  String get resultsHearCorrect => 'Hear correct';

  @override
  String get resultsMyAudio => 'My audio';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressWeeklySummary => 'This Week';

  @override
  String get progressSessions => 'sessions';

  @override
  String get progressMinutes => 'minutes';

  @override
  String get progressAvgScore => 'Avg score';

  @override
  String progressStreak(int days) {
    return '$days day streak';
  }

  @override
  String get progressActivity => 'Activity';

  @override
  String get progressSurahsMastery => 'Surah Mastery';

  @override
  String get progressFocusAreas => 'Focus Areas';

  @override
  String get progressNoData => 'Start reciting to see your progress';

  @override
  String get progressTajweedMastery => 'Tajweed Mastery';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get settingsName => 'Name';

  @override
  String get settingsLevel => 'Recitation Level';

  @override
  String get settingsLevelBeginner => 'Beginner';

  @override
  String get settingsLevelIntermediate => 'Intermediate';

  @override
  String get settingsLevelAdvanced => 'Advanced';

  @override
  String get settingsDailyGoal => 'Daily Goal';

  @override
  String get settingsQuranDisplay => 'Quran Display';

  @override
  String get settingsScript => 'Script';

  @override
  String get settingsFontSize => 'Font Size';

  @override
  String get settingsTajweedColors => 'Tajweed Colors';

  @override
  String get settingsTranslationLanguage => 'Translation Language';

  @override
  String get settingsAudio => 'Audio';

  @override
  String get settingsQari => 'Qari';

  @override
  String get settingsPlaybackSpeed => 'Playback Speed';

  @override
  String get settingsScoring => 'Scoring';

  @override
  String get settingsDifficulty => 'Difficulty';

  @override
  String get settingsApp => 'App';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsOpenSource => 'Open Source — MIT License';

  @override
  String get settingsCredits => 'Data: quran.com • EveryAyah.com';

  @override
  String get settingsBookmarks => 'Bookmarks';

  @override
  String get bookmarksTitle => 'Bookmarks';

  @override
  String get bookmarksEmpty => 'No bookmarks yet';

  @override
  String get bookmarksEmptyHint => 'Tap ⊕ while reading to save your place';

  @override
  String bookmarksPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get timeJustNow => 'just now';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes minutes ago';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String get timeYesterday => 'yesterday';

  @override
  String timeDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get errorLoadFailed => 'Failed to load';

  @override
  String get errorRetry => 'Retry';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String get onboardingWelcomeTitle => 'Welcome to Itqan';

  @override
  String get onboardingWelcomeSubtitle => 'Perfect your Quran recitation';

  @override
  String get onboardingLevelTitle => 'What\'s your level?';

  @override
  String get onboardingLevelBeginner => 'Beginner — Learning to read';

  @override
  String get onboardingLevelIntermediate =>
      'Intermediate — Want better tajweed';

  @override
  String get onboardingLevelAdvanced => 'Advanced — Want to perfect recitation';

  @override
  String get onboardingGoalTitle => 'How many minutes per day?';

  @override
  String get onboardingStartBtn => 'Start with Al-Fatihah';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get wordDetailClose => 'Close';

  @override
  String get wordDetailYouSaid => 'What you said';

  @override
  String get wordDetailCorrect => 'Correct';

  @override
  String get wordDetailTajweedRule => 'Tajweed Rule';

  @override
  String get wordDetailPracticeAyah => 'Practice this Ayah';
}
