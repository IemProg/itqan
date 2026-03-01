import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../quran/models/ayah.dart';
import '../quran/services/quran_service.dart';
import '../recitation/recitation_screen.dart';
import '../tajweed/tajweed_data.dart';
import '../settings/settings_service.dart';

final quranServiceProvider = Provider((ref) => QuranService());

final surahsProvider = FutureProvider<List<Surah>>((ref) async {
  final service = ref.read(quranServiceProvider);
  await service.init();
  return service.getSurahs();
});

final ayahsProvider = FutureProvider.family<List<Ayah>, int>((ref, surahNumber) async {
  final service = ref.read(quranServiceProvider);
  await service.init();
  return service.getAyahs(surahNumber);
});

class MushafScreen extends ConsumerWidget {
  const MushafScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(surahsProvider);

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        title: const Text('Quran', style: ItqanTypography.heading2),
        backgroundColor: ItqanColors.void_,
      ),
      body: surahsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: ItqanColors.gold),
        ),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, color: ItqanColors.mist, size: 48),
              const SizedBox(height: ItqanSpacing.md),
              Text('Could not load surahs\n$err', style: ItqanTypography.body, textAlign: TextAlign.center),
              const SizedBox(height: ItqanSpacing.md),
              ElevatedButton(
                onPressed: () => ref.refresh(surahsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (surahs) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: ItqanSpacing.md),
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            return _SurahTile(surah: surah);
          },
        ),
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  final Surah surah;
  const _SurahTile({required this.surah});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _AyahListScreen(surah: surah)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ItqanSpacing.md,
        vertical: ItqanSpacing.sm,
      ),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: ItqanColors.charcoal,
          borderRadius: BorderRadius.circular(ItqanRadius.md),
        ),
        alignment: Alignment.center,
        child: Text(
          surah.number.toString(),
          style: const TextStyle(
            color: ItqanColors.gold,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(surah.nameSimple, style: ItqanTypography.label),
          Text(
            surah.nameArabic,
            style: const TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: 18,
              color: ItqanColors.goldLight,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
      subtitle: Text(
        '${surah.nameTranslation} • ${surah.ayahCount} ayahs • ${surah.revelationPlace}',
        style: ItqanTypography.caption,
      ),
    );
  }
}

class _AyahListScreen extends ConsumerStatefulWidget {
  final Surah surah;
  const _AyahListScreen({required this.surah});

  @override
  ConsumerState<_AyahListScreen> createState() => _AyahListScreenState();
}

class _AyahListScreenState extends ConsumerState<_AyahListScreen> {
  bool _tajweedEnabled = false;

  @override
  Widget build(BuildContext context) {
    final surah = widget.surah;
    final ayahsAsync = ref.watch(ayahsProvider(surah.number));
    final settings = ref.watch(settingsProvider);
    // Sync toggle with global setting on first build
    if (settings.tajweedOverlay != _tajweedEnabled && !_tajweedEnabled) {
      _tajweedEnabled = settings.tajweedOverlay;
    }

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        title: Text(surah.nameSimple, style: ItqanTypography.heading2),
        backgroundColor: ItqanColors.void_,
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high_rounded, color: _tajweedEnabled ? ItqanColors.gold : ItqanColors.mist),
            tooltip: 'Tajweed Overlay',
            onPressed: () => setState(() => _tajweedEnabled = !_tajweedEnabled),
          ),
          Padding(
            padding: const EdgeInsets.only(right: ItqanSpacing.md),
            child: Text(
              surah.nameArabic,
              style: const TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: 20, color: ItqanColors.gold),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
      body: ayahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: ItqanColors.gold)),
        error: (err, _) => Center(child: Text('Error: $err', style: ItqanTypography.body)),
        data: (ayahs) => ListView.builder(
          padding: const EdgeInsets.all(ItqanSpacing.md),
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            final ayah = ayahs[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecitationScreen(ayah: ayah, surahName: surah.nameSimple),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: ItqanSpacing.md),
                padding: const EdgeInsets.all(ItqanSpacing.md),
                decoration: BoxDecoration(
                  color: ItqanColors.onyx,
                  borderRadius: BorderRadius.circular(ItqanRadius.lg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: ItqanColors.goldShimmer,
                            borderRadius: BorderRadius.circular(ItqanRadius.full),
                          ),
                          child: Text('${ayah.ayahNumber}', style: const TextStyle(color: ItqanColors.gold, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const Icon(Icons.mic_rounded, color: ItqanColors.mist, size: 18),
                      ],
                    ),
                    const SizedBox(height: ItqanSpacing.sm),
                    _tajweedEnabled
                        ? _TajweedAyahText(surahNum: surah.number, ayah: ayah)
                        : Text(
                            ayah.textUthmani,
                            style: const TextStyle(
                              fontFamily: 'NotoNaskhArabic',
                              fontSize: 22,
                              height: 2.0,
                              color: ItqanColors.snow,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                    if (ayah.translation.isNotEmpty) ...[
                      const SizedBox(height: ItqanSpacing.sm),
                      Text(
                        ayah.translation,
                        style: ItqanTypography.caption,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class _TajweedAyahText extends StatelessWidget {
  final int surahNum;
  final Ayah ayah;
  const _TajweedAyahText({required this.surahNum, required this.ayah});

  @override
  Widget build(BuildContext context) {
    final words = ayah.textUthmani.split(' ');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: words.asMap().entries.map((entry) {
          final word = entry.value;
          final key = '\$surahNum:\${ayah.ayahNumber}:\${entry.key}';
          final rule = tajweedAnnotations[key];
          return Container(
            padding: rule != null ? const EdgeInsets.symmetric(horizontal: 3, vertical: 1) : EdgeInsets.zero,
            decoration: rule != null
                ? BoxDecoration(
                    color: tajweedColor(rule).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Text(
              word,
              style: TextStyle(
                fontFamily: 'NotoNaskhArabic',
                fontSize: 22,
                height: 2.0,
                color: rule != null ? tajweedColor(rule) : ItqanColors.snow,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
