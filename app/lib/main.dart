import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open all boxes
  await Hive.openBox('settings');
  await Hive.openBox('sessions');
  await Hive.openBox('reading_positions');

  final onboardingDone = Hive.box('settings').get('onboarding_done', defaultValue: false) as bool;

  runApp(ProviderScope(
    child: ItqanAppWithOnboarding(showOnboarding: !onboardingDone),
  ));
}

class ItqanAppWithOnboarding extends StatelessWidget {
  final bool showOnboarding;
  const ItqanAppWithOnboarding({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itqan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        colorScheme: const ColorScheme.dark(primary: Color(0xFFC9982E)),
      ),
      home: showOnboarding ? const OnboardingScreen() : const HomeScreen(),
    );
  }
}
