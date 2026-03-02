import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../surah_browser/surah_browser_screen.dart';
import '../progress/progress_screen.dart';
import '../settings/settings_screen.dart';
import '../settings/settings_service.dart';
import '../quran/services/quran_service.dart';
import '../recitation/recitation_screen.dart';

// Index provider for bottom nav
final _navIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(_navIndexProvider);

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      body: IndexedStack(
        index: navIndex == 2 ? 0 : navIndex, // center tab keeps home visible
        children: [
          const _HomeBody(),
          const SurahBrowserScreen(),
          const ProgressScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: ItqanColors.obsidian,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', index: 0, current: navIndex, onTap: (i) => ref.read(_navIndexProvider.notifier).state = i),
              _NavItem(icon: Icons.menu_book_rounded, label: 'Quran', index: 1, current: navIndex, onTap: (i) => ref.read(_navIndexProvider.notifier).state = i),
              const SizedBox(width: 72), // notch spacer
              _NavItem(icon: Icons.bar_chart_rounded, label: 'Progress', index: 3, current: navIndex, onTap: (i) => ref.read(_navIndexProvider.notifier).state = i),
              _NavItem(icon: Icons.settings_rounded, label: 'Settings', index: 4, current: navIndex, onTap: (i) => ref.read(_navIndexProvider.notifier).state = i),
            ],
          ),
        ),
      ),
      floatingActionButton: _RecordFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon, required this.label,
    required this.index, required this.current, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = current == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: active ? ItqanColors.gold : ItqanColors.mist, size: 22),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: active ? ItqanColors.gold : ItqanColors.mist, fontSize: 10, fontWeight: active ? FontWeight.w700 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _RecordFAB extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(userPreferencesProvider);

    return GestureDetector(
      onTap: () async {
        final service = QuranService();
        await service.init();
        final ayahs = await service.getAyahs(prefs.lastSurah);
        if (!context.mounted) return;
        final ayah = ayahs.firstWhere(
          (a) => a.ayahNumber == prefs.lastAyah,
          orElse: () => ayahs.first,
        );
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => RecitationScreen(ayah: ayah, surahName: 'Surah ${prefs.lastSurah}'),
        ));
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [ItqanColors.goldLight, ItqanColors.gold],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [BoxShadow(color: ItqanColors.gold.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: const Icon(Icons.mic_rounded, color: ItqanColors.void_, size: 28),
      ),
    );
  }
}

// Home body content
class _HomeBody extends ConsumerWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(ItqanSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: ItqanSpacing.md),
                const Text(
                  'السلام عليكم',
                  style: TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: 28, color: ItqanColors.gold, height: 1.5),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: ItqanSpacing.xs),
                const Text('Perfect your recitation, one ayah at a time.', style: ItqanTypography.body, textAlign: TextAlign.center),
                const SizedBox(height: ItqanSpacing.xl),
                _ContinueCard(
                  onTap: () async {
                    final prefs = ref.read(userPreferencesProvider);
                    final service = QuranService();
                    await service.init();
                    final ayahs = await service.getAyahs(prefs.lastSurah);
                    if (!context.mounted) return;
                    final ayah = ayahs.firstWhere(
                      (a) => a.ayahNumber == prefs.lastAyah,
                      orElse: () => ayahs.first,
                    );
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => RecitationScreen(ayah: ayah, surahName: 'Al-Fatiha'),
                    ));
                  },
                ),
                const SizedBox(height: ItqanSpacing.lg),
                const Text('Practice', style: ItqanTypography.label),
                const SizedBox(height: ItqanSpacing.md),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: ItqanSpacing.md,
                  mainAxisSpacing: ItqanSpacing.md,
                  childAspectRatio: 1.4,
                  children: [
                    _ActionCard(
                      icon: Icons.menu_book_rounded, label: 'Read', subtitle: 'Browse Quran',
                      onTap: () => ref.read(_navIndexProvider.notifier).state = 1,
                    ),
                    _ActionCard(
                      icon: Icons.psychology_rounded, label: 'Memorize', subtitle: 'Hifz mode',
                      onTap: () => ref.read(_navIndexProvider.notifier).state = 1,
                    ),
                    _ActionCard(
                      icon: Icons.headphones_rounded, label: 'Listen', subtitle: 'Qari audio',
                      onTap: () => ref.read(_navIndexProvider.notifier).state = 1,
                    ),
                    _ActionCard(
                      icon: Icons.bar_chart_rounded, label: 'Progress', subtitle: 'Your stats',
                      onTap: () => ref.read(_navIndexProvider.notifier).state = 3,
                    ),
                  ],
                ),
                const SizedBox(height: ItqanSpacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final VoidCallback onTap;
  const _ContinueCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ItqanSpacing.lg),
        decoration: BoxDecoration(
          color: ItqanColors.onyx,
          borderRadius: BorderRadius.circular(ItqanRadius.lg),
          border: Border.all(color: ItqanColors.goldGlow, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: ItqanColors.goldShimmer,
                borderRadius: BorderRadius.circular(ItqanRadius.md),
                border: Border.all(color: ItqanColors.goldGlow, width: 1),
              ),
              child: const Icon(Icons.play_arrow_rounded, color: ItqanColors.gold, size: 28),
            ),
            const SizedBox(width: ItqanSpacing.md),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Continue Recitation', style: ItqanTypography.label),
                  SizedBox(height: 2),
                  Text('Pick up where you left off', style: ItqanTypography.caption),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: ItqanColors.mist, size: 16),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.label, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ItqanSpacing.md),
        decoration: BoxDecoration(color: ItqanColors.onyx, borderRadius: BorderRadius.circular(ItqanRadius.lg)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: ItqanColors.gold, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: ItqanTypography.label),
                Text(subtitle, style: ItqanTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
