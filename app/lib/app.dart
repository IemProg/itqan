import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

class ItqanApp extends StatelessWidget {
  const ItqanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itqan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
