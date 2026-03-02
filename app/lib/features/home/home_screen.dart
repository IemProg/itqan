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
import '../mushaf/mushaf_page_screen.dart';
import '../mushaf/providers/reading_position_provider.dart';
import '../mushaf/services/reading_position_service.dart';

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
        index: navIndex == 2 ? 0 : navIndex,
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
              const SizedBox(width: 72),
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
                // Mushaf "Continue Reading" card
                const _MushafContinueCard(),
                const SizedBox(height: ItqanSpacing.md),
                // Recitation continue card
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

// ─── Mushaf Continue Reading Card ─────────────────────────────────────────────

class _MushafContinueCard extends ConsumerWidget {
  const _MushafContinueCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastPositionAsync = ref.watch(lastReadingPositionProvider);

    return lastPositionAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (position) {
        if (position == null) {
          // First time — show start card
          return _MushafStartCard();
        }
        return _MushafResumeCard(position: position);
      },
    );
  }
}

class _MushafStartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      decoration: BoxDecoration(
        color: ItqanColors.onyx,
        borderRadius: BorderRadius.circular(ItqanRadius.lg),
        border: Border.all(color: ItqanColors.goldGlow, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_stories_rounded, color: ItqanColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text('Read the Mushaf', style: ItqanTypography.label),
            ],
          ),
          const SizedBox(height: ItqanSpacing.sm),
          const Text(
            'Start with Al-Fatiha',
            style: TextStyle(color: ItqanColors.mist, fontSize: 13),
          ),
          const SizedBox(height: ItqanSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ItqanColors.gold,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MushafPageScreen(startPage: 1)),
                );
              },
              child: const Text(
                'Open Mushaf  ١',
                style: TextStyle(color: ItqanColors.void_, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MushafResumeCard extends StatelessWidget {
  final ReadingPosition position;
  const _MushafResumeCard({required this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      decoration: BoxDecoration(
        color: ItqanColors.onyx,
        borderRadius: BorderRadius.circular(ItqanRadius.lg),
        border: Border.all(color: ItqanColors.goldGlow, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_stories_rounded, color: ItqanColors.gold, size: 20),
              const SizedBox(width: 8),
              const Text('Continue Reading', style: ItqanTypography.label),
              const Spacer(),
              Text(
                relativeTimestamp(position.savedAt),
                style: const TextStyle(color: ItqanColors.slate, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: ItqanSpacing.sm),
          if (position.surahNameArabic.isNotEmpty)
            Text(
              position.surahNameArabic,
              style: const TextStyle(
                fontFamily: 'NotoNaskhArabic',
                fontSize: 20,
                color: ItqanColors.goldLight,
                height: 1.8,
              ),
              textDirection: TextDirection.rtl,
            ),
          Text(
            '${position.surahNameSimple} · Ayah ${position.ayahNumber} · Page ${position.pageNumber}',
            style: const TextStyle(color: ItqanColors.mist, fontSize: 13),
          ),
          const SizedBox(height: ItqanSpacing.md),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ItqanColors.gold,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MushafPageScreen(startPage: position.pageNumber),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue →',
                    style: TextStyle(color: ItqanColors.void_, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: ItqanSpacing.sm),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: ItqanColors.charcoal),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MushafPageScreen(startPage: 1),
                      ),
                    );
                  },
                  child: const Text(
                    'Start from ١',
                    style: TextStyle(color: ItqanColors.mist, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Recitation Continue Card ─────────────────────────────────────────────────

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
