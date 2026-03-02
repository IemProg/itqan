import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itqan/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';
import 'features/settings/settings_service.dart';

// Locale provider — driven by user settings
final localeProvider = Provider<Locale>((ref) {
  final settings = ref.watch(settingsProvider);
  switch (settings.language) {
    case 'arabic':
      return const Locale('ar');
    case 'english':
      return const Locale('en');
    case 'french':
      return const Locale('fr');
    default:
      return const Locale('ar'); // Arabic is DEFAULT
  }
});

class ItqanApp extends ConsumerWidget {
  const ItqanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'إتقان',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,

      // Localization
      locale: locale,
      supportedLocales: const [
        Locale('ar'), // Arabic — DEFAULT
        Locale('en'), // English
        Locale('fr'), // French
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // RTL for Arabic, LTR for others
      builder: (context, child) {
        final isArabic = locale.languageCode == 'ar';
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },

      home: const HomeScreen(),
    );
  }
}
