// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'إتقان';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navQuran => 'القرآن';

  @override
  String get navProgress => 'التقدم';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get homeGreeting => 'السلام عليكم';

  @override
  String get homeSubtitle => 'أهلاً بك في إتقان';

  @override
  String get homeContinueReading => 'متابعة القراءة';

  @override
  String get homeStartReading => 'ابدأ بالفاتحة';

  @override
  String get homeContinueBtn => 'متابعة ←';

  @override
  String get homeStartFromBeginning => 'من البداية ١';

  @override
  String get homeLastRead => 'آخر قراءة';

  @override
  String get homePracticeMode => 'وضع الممارسة';

  @override
  String get homeReadMode => 'وضع القراءة';

  @override
  String get homeListenMode => 'وضع الاستماع';

  @override
  String get homeProgressMode => 'التقدم';

  @override
  String get quranTitle => 'القرآن الكريم';

  @override
  String get quranSurahsTab => 'السور';

  @override
  String get quranJuzTab => 'الأجزاء';

  @override
  String get quranSearchHint => 'ابحث عن سورة...';

  @override
  String quranAyahCount(int count) {
    return '$count آيات';
  }

  @override
  String get quranMakki => 'مكية';

  @override
  String get quranMadani => 'مدنية';

  @override
  String quranJuzLabel(int number) {
    return 'الجزء $number';
  }

  @override
  String get quranReadBtn => 'قراءة';

  @override
  String get quranPracticeBtn => 'ممارسة';

  @override
  String mushafPage(int page) {
    return 'صفحة $page';
  }

  @override
  String mushafJuz(int number) {
    return 'الجزء $number';
  }

  @override
  String get mushafBookmarkSaved => 'تم حفظ الإشارة ✓';

  @override
  String get mushafBookmarkRemoved => 'تمت إزالة الإشارة';

  @override
  String get mushafJumpToPage => 'انتقل إلى صفحة';

  @override
  String get mushafJumpConfirm => 'انتقال';

  @override
  String get mushafJumpCancel => 'إلغاء';

  @override
  String get mushafTranslationToggle => 'الترجمة';

  @override
  String get mushafTajweedToggle => 'التجويد';

  @override
  String get recitationTitle => 'التلاوة';

  @override
  String get recitationListenFirst => 'استمع أولاً';

  @override
  String get recitationRecord => 'سجّل';

  @override
  String get recitationStop => 'إيقاف';

  @override
  String get recitationRetry => 'إعادة المحاولة';

  @override
  String get recitationNextAyah => 'الآية التالية ←';

  @override
  String get recitationRecording => 'جارٍ التسجيل';

  @override
  String get recitationProcessing => 'جارٍ التحليل...';

  @override
  String get resultsTitle => 'النتائج';

  @override
  String get resultsOverallScore => 'النتيجة الإجمالية';

  @override
  String get resultsWordAccuracy => 'دقة الكلمات';

  @override
  String get resultsLetterAccuracy => 'دقة الحروف';

  @override
  String get resultsTajweed => 'التجويد';

  @override
  String get resultsFluency => 'الطلاقة';

  @override
  String get resultsExcellent => 'ممتاز! ما شاء الله';

  @override
  String get resultsGood => 'أداء جيد! استمر';

  @override
  String get resultsNeedsWork => 'هيا نتحسن معاً';

  @override
  String get resultsMistakeCards => 'الأخطاء';

  @override
  String get resultsHearCorrect => 'استمع للصحيح';

  @override
  String get resultsMyAudio => 'تسجيلي';

  @override
  String get progressTitle => 'التقدم';

  @override
  String get progressWeeklySummary => 'ملخص الأسبوع';

  @override
  String get progressSessions => 'جلسات';

  @override
  String get progressMinutes => 'دقيقة';

  @override
  String get progressAvgScore => 'متوسط النتيجة';

  @override
  String progressStreak(int days) {
    return 'سلسلة $days يوم';
  }

  @override
  String get progressActivity => 'نشاطي';

  @override
  String get progressSurahsMastery => 'إتقان السور';

  @override
  String get progressFocusAreas => 'مجالات التحسين';

  @override
  String get progressNoData => 'ابدأ التلاوة لرؤية تقدمك';

  @override
  String get progressTajweedMastery => 'إتقان التجويد';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsProfile => 'الملف الشخصي';

  @override
  String get settingsName => 'الاسم';

  @override
  String get settingsLevel => 'مستوى التلاوة';

  @override
  String get settingsLevelBeginner => 'مبتدئ';

  @override
  String get settingsLevelIntermediate => 'متوسط';

  @override
  String get settingsLevelAdvanced => 'متقدم';

  @override
  String get settingsDailyGoal => 'الهدف اليومي';

  @override
  String get settingsQuranDisplay => 'عرض القرآن';

  @override
  String get settingsScript => 'الرسم الإملائي';

  @override
  String get settingsFontSize => 'حجم الخط';

  @override
  String get settingsTajweedColors => 'ألوان التجويد';

  @override
  String get settingsTranslationLanguage => 'لغة الترجمة';

  @override
  String get settingsAudio => 'الصوت';

  @override
  String get settingsQari => 'القارئ';

  @override
  String get settingsPlaybackSpeed => 'سرعة التشغيل';

  @override
  String get settingsScoring => 'التقييم';

  @override
  String get settingsDifficulty => 'مستوى الصعوبة';

  @override
  String get settingsApp => 'التطبيق';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsAbout => 'حول التطبيق';

  @override
  String get settingsVersion => 'الإصدار';

  @override
  String get settingsOpenSource => 'مفتوح المصدر — رخصة MIT';

  @override
  String get settingsCredits => 'مصادر البيانات: quran.com • EveryAyah.com';

  @override
  String get settingsBookmarks => 'الإشارات المرجعية';

  @override
  String get bookmarksTitle => 'الإشارات المرجعية';

  @override
  String get bookmarksEmpty => 'لا توجد إشارات بعد';

  @override
  String get bookmarksEmptyHint => 'اضغط ⊕ أثناء القراءة لحفظ موضعك';

  @override
  String bookmarksPageLabel(int page) {
    return 'صفحة $page';
  }

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String get timeYesterday => 'أمس';

  @override
  String timeDaysAgo(int days) {
    return 'منذ $days أيام';
  }

  @override
  String get errorLoadFailed => 'تعذّر التحميل';

  @override
  String get errorRetry => 'إعادة المحاولة';

  @override
  String get errorNoInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get onboardingWelcomeTitle => 'أهلاً بك في إتقان';

  @override
  String get onboardingWelcomeSubtitle => 'أتقِن تلاوة القرآن الكريم';

  @override
  String get onboardingLevelTitle => 'ما مستواك؟';

  @override
  String get onboardingLevelBeginner => 'مبتدئ — أتعلم القراءة';

  @override
  String get onboardingLevelIntermediate => 'متوسط — أريد تحسين التجويد';

  @override
  String get onboardingLevelAdvanced => 'متقدم — أريد إتقان التلاوة';

  @override
  String get onboardingGoalTitle => 'كم دقيقة يومياً؟';

  @override
  String get onboardingStartBtn => 'ابدأ بالفاتحة';

  @override
  String get onboardingContinue => 'متابعة';

  @override
  String get wordDetailClose => 'إغلاق';

  @override
  String get wordDetailYouSaid => 'ما قلته';

  @override
  String get wordDetailCorrect => 'الصحيح';

  @override
  String get wordDetailTajweedRule => 'قاعدة التجويد';

  @override
  String get wordDetailPracticeAyah => 'تدرّب على هذه الآية';
}
