import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'إتقان'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navQuran.
  ///
  /// In ar, this message translates to:
  /// **'القرآن'**
  String get navQuran;

  /// No description provided for @navProgress.
  ///
  /// In ar, this message translates to:
  /// **'التقدم'**
  String get navProgress;

  /// No description provided for @navSettings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get navSettings;

  /// No description provided for @homeGreeting.
  ///
  /// In ar, this message translates to:
  /// **'السلام عليكم'**
  String get homeGreeting;

  /// No description provided for @homeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك في إتقان'**
  String get homeSubtitle;

  /// No description provided for @homeContinueReading.
  ///
  /// In ar, this message translates to:
  /// **'متابعة القراءة'**
  String get homeContinueReading;

  /// No description provided for @homeStartReading.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ بالفاتحة'**
  String get homeStartReading;

  /// No description provided for @homeContinueBtn.
  ///
  /// In ar, this message translates to:
  /// **'متابعة ←'**
  String get homeContinueBtn;

  /// No description provided for @homeStartFromBeginning.
  ///
  /// In ar, this message translates to:
  /// **'من البداية ١'**
  String get homeStartFromBeginning;

  /// No description provided for @homeLastRead.
  ///
  /// In ar, this message translates to:
  /// **'آخر قراءة'**
  String get homeLastRead;

  /// No description provided for @homePracticeMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الممارسة'**
  String get homePracticeMode;

  /// No description provided for @homeReadMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع القراءة'**
  String get homeReadMode;

  /// No description provided for @homeListenMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاستماع'**
  String get homeListenMode;

  /// No description provided for @homeProgressMode.
  ///
  /// In ar, this message translates to:
  /// **'التقدم'**
  String get homeProgressMode;

  /// No description provided for @quranTitle.
  ///
  /// In ar, this message translates to:
  /// **'القرآن الكريم'**
  String get quranTitle;

  /// No description provided for @quranSurahsTab.
  ///
  /// In ar, this message translates to:
  /// **'السور'**
  String get quranSurahsTab;

  /// No description provided for @quranJuzTab.
  ///
  /// In ar, this message translates to:
  /// **'الأجزاء'**
  String get quranJuzTab;

  /// No description provided for @quranSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن سورة...'**
  String get quranSearchHint;

  /// No description provided for @quranAyahCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} آيات'**
  String quranAyahCount(int count);

  /// No description provided for @quranMakki.
  ///
  /// In ar, this message translates to:
  /// **'مكية'**
  String get quranMakki;

  /// No description provided for @quranMadani.
  ///
  /// In ar, this message translates to:
  /// **'مدنية'**
  String get quranMadani;

  /// No description provided for @quranJuzLabel.
  ///
  /// In ar, this message translates to:
  /// **'الجزء {number}'**
  String quranJuzLabel(int number);

  /// No description provided for @quranReadBtn.
  ///
  /// In ar, this message translates to:
  /// **'قراءة'**
  String get quranReadBtn;

  /// No description provided for @quranPracticeBtn.
  ///
  /// In ar, this message translates to:
  /// **'ممارسة'**
  String get quranPracticeBtn;

  /// No description provided for @mushafPage.
  ///
  /// In ar, this message translates to:
  /// **'صفحة {page}'**
  String mushafPage(int page);

  /// No description provided for @mushafJuz.
  ///
  /// In ar, this message translates to:
  /// **'الجزء {number}'**
  String mushafJuz(int number);

  /// No description provided for @mushafBookmarkSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ الإشارة ✓'**
  String get mushafBookmarkSaved;

  /// No description provided for @mushafBookmarkRemoved.
  ///
  /// In ar, this message translates to:
  /// **'تمت إزالة الإشارة'**
  String get mushafBookmarkRemoved;

  /// No description provided for @mushafJumpToPage.
  ///
  /// In ar, this message translates to:
  /// **'انتقل إلى صفحة'**
  String get mushafJumpToPage;

  /// No description provided for @mushafJumpConfirm.
  ///
  /// In ar, this message translates to:
  /// **'انتقال'**
  String get mushafJumpConfirm;

  /// No description provided for @mushafJumpCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get mushafJumpCancel;

  /// No description provided for @mushafTranslationToggle.
  ///
  /// In ar, this message translates to:
  /// **'الترجمة'**
  String get mushafTranslationToggle;

  /// No description provided for @mushafTajweedToggle.
  ///
  /// In ar, this message translates to:
  /// **'التجويد'**
  String get mushafTajweedToggle;

  /// No description provided for @recitationTitle.
  ///
  /// In ar, this message translates to:
  /// **'التلاوة'**
  String get recitationTitle;

  /// No description provided for @recitationListenFirst.
  ///
  /// In ar, this message translates to:
  /// **'استمع أولاً'**
  String get recitationListenFirst;

  /// No description provided for @recitationRecord.
  ///
  /// In ar, this message translates to:
  /// **'سجّل'**
  String get recitationRecord;

  /// No description provided for @recitationStop.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف'**
  String get recitationStop;

  /// No description provided for @recitationRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get recitationRetry;

  /// No description provided for @recitationNextAyah.
  ///
  /// In ar, this message translates to:
  /// **'الآية التالية ←'**
  String get recitationNextAyah;

  /// No description provided for @recitationRecording.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التسجيل'**
  String get recitationRecording;

  /// No description provided for @recitationProcessing.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحليل...'**
  String get recitationProcessing;

  /// No description provided for @resultsTitle.
  ///
  /// In ar, this message translates to:
  /// **'النتائج'**
  String get resultsTitle;

  /// No description provided for @resultsOverallScore.
  ///
  /// In ar, this message translates to:
  /// **'النتيجة الإجمالية'**
  String get resultsOverallScore;

  /// No description provided for @resultsWordAccuracy.
  ///
  /// In ar, this message translates to:
  /// **'دقة الكلمات'**
  String get resultsWordAccuracy;

  /// No description provided for @resultsLetterAccuracy.
  ///
  /// In ar, this message translates to:
  /// **'دقة الحروف'**
  String get resultsLetterAccuracy;

  /// No description provided for @resultsTajweed.
  ///
  /// In ar, this message translates to:
  /// **'التجويد'**
  String get resultsTajweed;

  /// No description provided for @resultsFluency.
  ///
  /// In ar, this message translates to:
  /// **'الطلاقة'**
  String get resultsFluency;

  /// No description provided for @resultsExcellent.
  ///
  /// In ar, this message translates to:
  /// **'ممتاز! ما شاء الله'**
  String get resultsExcellent;

  /// No description provided for @resultsGood.
  ///
  /// In ar, this message translates to:
  /// **'أداء جيد! استمر'**
  String get resultsGood;

  /// No description provided for @resultsNeedsWork.
  ///
  /// In ar, this message translates to:
  /// **'هيا نتحسن معاً'**
  String get resultsNeedsWork;

  /// No description provided for @resultsMistakeCards.
  ///
  /// In ar, this message translates to:
  /// **'الأخطاء'**
  String get resultsMistakeCards;

  /// No description provided for @resultsHearCorrect.
  ///
  /// In ar, this message translates to:
  /// **'استمع للصحيح'**
  String get resultsHearCorrect;

  /// No description provided for @resultsMyAudio.
  ///
  /// In ar, this message translates to:
  /// **'تسجيلي'**
  String get resultsMyAudio;

  /// No description provided for @progressTitle.
  ///
  /// In ar, this message translates to:
  /// **'التقدم'**
  String get progressTitle;

  /// No description provided for @progressWeeklySummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص الأسبوع'**
  String get progressWeeklySummary;

  /// No description provided for @progressSessions.
  ///
  /// In ar, this message translates to:
  /// **'جلسات'**
  String get progressSessions;

  /// No description provided for @progressMinutes.
  ///
  /// In ar, this message translates to:
  /// **'دقيقة'**
  String get progressMinutes;

  /// No description provided for @progressAvgScore.
  ///
  /// In ar, this message translates to:
  /// **'متوسط النتيجة'**
  String get progressAvgScore;

  /// No description provided for @progressStreak.
  ///
  /// In ar, this message translates to:
  /// **'سلسلة {days} يوم'**
  String progressStreak(int days);

  /// No description provided for @progressActivity.
  ///
  /// In ar, this message translates to:
  /// **'نشاطي'**
  String get progressActivity;

  /// No description provided for @progressSurahsMastery.
  ///
  /// In ar, this message translates to:
  /// **'إتقان السور'**
  String get progressSurahsMastery;

  /// No description provided for @progressFocusAreas.
  ///
  /// In ar, this message translates to:
  /// **'مجالات التحسين'**
  String get progressFocusAreas;

  /// No description provided for @progressNoData.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ التلاوة لرؤية تقدمك'**
  String get progressNoData;

  /// No description provided for @progressTajweedMastery.
  ///
  /// In ar, this message translates to:
  /// **'إتقان التجويد'**
  String get progressTajweedMastery;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @settingsProfile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get settingsProfile;

  /// No description provided for @settingsName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get settingsName;

  /// No description provided for @settingsLevel.
  ///
  /// In ar, this message translates to:
  /// **'مستوى التلاوة'**
  String get settingsLevel;

  /// No description provided for @settingsLevelBeginner.
  ///
  /// In ar, this message translates to:
  /// **'مبتدئ'**
  String get settingsLevelBeginner;

  /// No description provided for @settingsLevelIntermediate.
  ///
  /// In ar, this message translates to:
  /// **'متوسط'**
  String get settingsLevelIntermediate;

  /// No description provided for @settingsLevelAdvanced.
  ///
  /// In ar, this message translates to:
  /// **'متقدم'**
  String get settingsLevelAdvanced;

  /// No description provided for @settingsDailyGoal.
  ///
  /// In ar, this message translates to:
  /// **'الهدف اليومي'**
  String get settingsDailyGoal;

  /// No description provided for @settingsQuranDisplay.
  ///
  /// In ar, this message translates to:
  /// **'عرض القرآن'**
  String get settingsQuranDisplay;

  /// No description provided for @settingsScript.
  ///
  /// In ar, this message translates to:
  /// **'الرسم الإملائي'**
  String get settingsScript;

  /// No description provided for @settingsFontSize.
  ///
  /// In ar, this message translates to:
  /// **'حجم الخط'**
  String get settingsFontSize;

  /// No description provided for @settingsTajweedColors.
  ///
  /// In ar, this message translates to:
  /// **'ألوان التجويد'**
  String get settingsTajweedColors;

  /// No description provided for @settingsTranslationLanguage.
  ///
  /// In ar, this message translates to:
  /// **'لغة الترجمة'**
  String get settingsTranslationLanguage;

  /// No description provided for @settingsAudio.
  ///
  /// In ar, this message translates to:
  /// **'الصوت'**
  String get settingsAudio;

  /// No description provided for @settingsQari.
  ///
  /// In ar, this message translates to:
  /// **'القارئ'**
  String get settingsQari;

  /// No description provided for @settingsPlaybackSpeed.
  ///
  /// In ar, this message translates to:
  /// **'سرعة التشغيل'**
  String get settingsPlaybackSpeed;

  /// No description provided for @settingsScoring.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get settingsScoring;

  /// No description provided for @settingsDifficulty.
  ///
  /// In ar, this message translates to:
  /// **'مستوى الصعوبة'**
  String get settingsDifficulty;

  /// No description provided for @settingsApp.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق'**
  String get settingsApp;

  /// No description provided for @settingsTheme.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get settingsTheme;

  /// No description provided for @settingsLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get settingsLanguage;

  /// No description provided for @settingsNotifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get settingsNotifications;

  /// No description provided for @settingsAbout.
  ///
  /// In ar, this message translates to:
  /// **'حول التطبيق'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار'**
  String get settingsVersion;

  /// No description provided for @settingsOpenSource.
  ///
  /// In ar, this message translates to:
  /// **'مفتوح المصدر — رخصة MIT'**
  String get settingsOpenSource;

  /// No description provided for @settingsCredits.
  ///
  /// In ar, this message translates to:
  /// **'مصادر البيانات: quran.com • EveryAyah.com'**
  String get settingsCredits;

  /// No description provided for @settingsBookmarks.
  ///
  /// In ar, this message translates to:
  /// **'الإشارات المرجعية'**
  String get settingsBookmarks;

  /// No description provided for @bookmarksTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشارات المرجعية'**
  String get bookmarksTitle;

  /// No description provided for @bookmarksEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشارات بعد'**
  String get bookmarksEmpty;

  /// No description provided for @bookmarksEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'اضغط ⊕ أثناء القراءة لحفظ موضعك'**
  String get bookmarksEmptyHint;

  /// No description provided for @bookmarksPageLabel.
  ///
  /// In ar, this message translates to:
  /// **'صفحة {page}'**
  String bookmarksPageLabel(int page);

  /// No description provided for @timeJustNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {minutes} دقيقة'**
  String timeMinutesAgo(int minutes);

  /// No description provided for @timeHoursAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {hours} ساعة'**
  String timeHoursAgo(int hours);

  /// No description provided for @timeYesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get timeYesterday;

  /// No description provided for @timeDaysAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {days} أيام'**
  String timeDaysAgo(int days);

  /// No description provided for @errorLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحميل'**
  String get errorLoadFailed;

  /// No description provided for @errorRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get errorRetry;

  /// No description provided for @errorNoInternet.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get errorNoInternet;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك في إتقان'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أتقِن تلاوة القرآن الكريم'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingLevelTitle.
  ///
  /// In ar, this message translates to:
  /// **'ما مستواك؟'**
  String get onboardingLevelTitle;

  /// No description provided for @onboardingLevelBeginner.
  ///
  /// In ar, this message translates to:
  /// **'مبتدئ — أتعلم القراءة'**
  String get onboardingLevelBeginner;

  /// No description provided for @onboardingLevelIntermediate.
  ///
  /// In ar, this message translates to:
  /// **'متوسط — أريد تحسين التجويد'**
  String get onboardingLevelIntermediate;

  /// No description provided for @onboardingLevelAdvanced.
  ///
  /// In ar, this message translates to:
  /// **'متقدم — أريد إتقان التلاوة'**
  String get onboardingLevelAdvanced;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In ar, this message translates to:
  /// **'كم دقيقة يومياً؟'**
  String get onboardingGoalTitle;

  /// No description provided for @onboardingStartBtn.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ بالفاتحة'**
  String get onboardingStartBtn;

  /// No description provided for @onboardingContinue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get onboardingContinue;

  /// No description provided for @wordDetailClose.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get wordDetailClose;

  /// No description provided for @wordDetailYouSaid.
  ///
  /// In ar, this message translates to:
  /// **'ما قلته'**
  String get wordDetailYouSaid;

  /// No description provided for @wordDetailCorrect.
  ///
  /// In ar, this message translates to:
  /// **'الصحيح'**
  String get wordDetailCorrect;

  /// No description provided for @wordDetailTajweedRule.
  ///
  /// In ar, this message translates to:
  /// **'قاعدة التجويد'**
  String get wordDetailTajweedRule;

  /// No description provided for @wordDetailPracticeAyah.
  ///
  /// In ar, this message translates to:
  /// **'تدرّب على هذه الآية'**
  String get wordDetailPracticeAyah;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
