// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Itqan';

  @override
  String get navHome => 'Accueil';

  @override
  String get navQuran => 'Coran';

  @override
  String get navProgress => 'Progrès';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get homeGreeting => 'Assalamu Alaikum';

  @override
  String get homeSubtitle => 'Bienvenue sur Itqan';

  @override
  String get homeContinueReading => 'Continuer la lecture';

  @override
  String get homeStartReading => 'Commencer par Al-Fatiha';

  @override
  String get homeContinueBtn => 'Continuer →';

  @override
  String get homeStartFromBeginning => 'Recommencer ١';

  @override
  String get homeLastRead => 'Dernière lecture';

  @override
  String get homePracticeMode => 'Pratique';

  @override
  String get homeReadMode => 'Lire';

  @override
  String get homeListenMode => 'Écouter';

  @override
  String get homeProgressMode => 'Progrès';

  @override
  String get quranTitle => 'Le Saint Coran';

  @override
  String get quranSurahsTab => 'Sourates';

  @override
  String get quranJuzTab => 'Jouz';

  @override
  String get quranSearchHint => 'Rechercher une sourate...';

  @override
  String quranAyahCount(int count) {
    return '$count versets';
  }

  @override
  String get quranMakki => 'Mecquoise';

  @override
  String get quranMadani => 'Médinoise';

  @override
  String quranJuzLabel(int number) {
    return 'Jouz $number';
  }

  @override
  String get quranReadBtn => 'Lire';

  @override
  String get quranPracticeBtn => 'Pratiquer';

  @override
  String mushafPage(int page) {
    return 'Page $page';
  }

  @override
  String mushafJuz(int number) {
    return 'Jouz $number';
  }

  @override
  String get mushafBookmarkSaved => 'Signet enregistré ✓';

  @override
  String get mushafBookmarkRemoved => 'Signet supprimé';

  @override
  String get mushafJumpToPage => 'Aller à la page';

  @override
  String get mushafJumpConfirm => 'Aller';

  @override
  String get mushafJumpCancel => 'Annuler';

  @override
  String get mushafTranslationToggle => 'Traduction';

  @override
  String get mushafTajweedToggle => 'Tajweed';

  @override
  String get recitationTitle => 'Récitation';

  @override
  String get recitationListenFirst => 'Écouter d\'abord';

  @override
  String get recitationRecord => 'Enregistrer';

  @override
  String get recitationStop => 'Arrêter';

  @override
  String get recitationRetry => 'Réessayer';

  @override
  String get recitationNextAyah => 'Verset suivant →';

  @override
  String get recitationRecording => 'Enregistrement';

  @override
  String get recitationProcessing => 'Analyse en cours...';

  @override
  String get resultsTitle => 'Résultats';

  @override
  String get resultsOverallScore => 'Score global';

  @override
  String get resultsWordAccuracy => 'Précision des mots';

  @override
  String get resultsLetterAccuracy => 'Précision des lettres';

  @override
  String get resultsTajweed => 'Tajweed';

  @override
  String get resultsFluency => 'Fluidité';

  @override
  String get resultsExcellent => 'Excellent ! Ma sha Allah';

  @override
  String get resultsGood => 'Bon progrès ! Continuez';

  @override
  String get resultsNeedsWork => 'Travaillons ensemble';

  @override
  String get resultsMistakeCards => 'Erreurs';

  @override
  String get resultsHearCorrect => 'Écouter la version correcte';

  @override
  String get resultsMyAudio => 'Mon enregistrement';

  @override
  String get progressTitle => 'Progrès';

  @override
  String get progressWeeklySummary => 'Cette semaine';

  @override
  String get progressSessions => 'séances';

  @override
  String get progressMinutes => 'minutes';

  @override
  String get progressAvgScore => 'Score moyen';

  @override
  String progressStreak(int days) {
    return '$days jours consécutifs';
  }

  @override
  String get progressActivity => 'Activité';

  @override
  String get progressSurahsMastery => 'Maîtrise des sourates';

  @override
  String get progressFocusAreas => 'Axes d\'amélioration';

  @override
  String get progressNoData => 'Commencez à réciter pour voir vos progrès';

  @override
  String get progressTajweedMastery => 'Maîtrise du tajweed';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsProfile => 'Profil';

  @override
  String get settingsName => 'Nom';

  @override
  String get settingsLevel => 'Niveau de récitation';

  @override
  String get settingsLevelBeginner => 'Débutant';

  @override
  String get settingsLevelIntermediate => 'Intermédiaire';

  @override
  String get settingsLevelAdvanced => 'Avancé';

  @override
  String get settingsDailyGoal => 'Objectif quotidien';

  @override
  String get settingsQuranDisplay => 'Affichage du Coran';

  @override
  String get settingsScript => 'Script';

  @override
  String get settingsFontSize => 'Taille de la police';

  @override
  String get settingsTajweedColors => 'Couleurs du tajweed';

  @override
  String get settingsTranslationLanguage => 'Langue de traduction';

  @override
  String get settingsAudio => 'Audio';

  @override
  String get settingsQari => 'Récitant';

  @override
  String get settingsPlaybackSpeed => 'Vitesse de lecture';

  @override
  String get settingsScoring => 'Évaluation';

  @override
  String get settingsDifficulty => 'Niveau de difficulté';

  @override
  String get settingsApp => 'Application';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsOpenSource => 'Open Source — Licence MIT';

  @override
  String get settingsCredits => 'Données : quran.com • EveryAyah.com';

  @override
  String get settingsBookmarks => 'Signets';

  @override
  String get bookmarksTitle => 'Signets';

  @override
  String get bookmarksEmpty => 'Aucun signet pour l\'instant';

  @override
  String get bookmarksEmptyHint =>
      'Appuyez sur ⊕ pendant la lecture pour sauvegarder votre position';

  @override
  String bookmarksPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String get timeJustNow => 'à l\'instant';

  @override
  String timeMinutesAgo(int minutes) {
    return 'il y a $minutes minutes';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'il y a $hours heures';
  }

  @override
  String get timeYesterday => 'hier';

  @override
  String timeDaysAgo(int days) {
    return 'il y a $days jours';
  }

  @override
  String get errorLoadFailed => 'Échec du chargement';

  @override
  String get errorRetry => 'Réessayer';

  @override
  String get errorNoInternet => 'Pas de connexion internet';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur Itqan';

  @override
  String get onboardingWelcomeSubtitle =>
      'Perfectionnez votre récitation du Coran';

  @override
  String get onboardingLevelTitle => 'Quel est votre niveau ?';

  @override
  String get onboardingLevelBeginner =>
      'Débutant — Apprentissage de la lecture';

  @override
  String get onboardingLevelIntermediate =>
      'Intermédiaire — Améliorer le tajweed';

  @override
  String get onboardingLevelAdvanced => 'Avancé — Perfectionner la récitation';

  @override
  String get onboardingGoalTitle => 'Combien de minutes par jour ?';

  @override
  String get onboardingStartBtn => 'Commencer par Al-Fatiha';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get wordDetailClose => 'Fermer';

  @override
  String get wordDetailYouSaid => 'Ce que vous avez dit';

  @override
  String get wordDetailCorrect => 'Correct';

  @override
  String get wordDetailTajweedRule => 'Règle du tajweed';

  @override
  String get wordDetailPracticeAyah => 'Pratiquer ce verset';
}
