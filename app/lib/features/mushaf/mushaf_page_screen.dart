import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../quran/models/ayah.dart';
import '../quran/services/quran_service.dart';
import '../recitation/recitation_screen.dart';
import 'mushaf_screen.dart'; // quranServiceProvider, surahsProvider
import 'providers/reading_position_provider.dart';
import 'services/reading_position_service.dart';

// ─── Providers ───────────────────────────────────────────────────────────────

final _pageDataProvider = FutureProvider.family<PageData, int>((ref, page) async {
  if (page < 1 || page > 604) {
    return PageData(pageNumber: page, juzNumber: 0, hizbNumber: 0, verses: []);
  }
  final service = ref.read(quranServiceProvider);
  await service.init();
  return service.getPage(page);
});

// ─── Screen ───────────────────────────────────────────────────────────────────

class MushafPageScreen extends ConsumerStatefulWidget {
  final int startPage;

  const MushafPageScreen({super.key, this.startPage = 1});

  @override
  ConsumerState<MushafPageScreen> createState() => _MushafPageScreenState();
}

class _MushafPageScreenState extends ConsumerState<MushafPageScreen> {
  late PageController _pageController;
  late int _currentPage;
  bool _showTranslation = false;

  // Auto-save debounce
  Timer? _saveDebounce;
  int _lastSavedPage = -1;

  // Bookmark state
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.startPage.clamp(1, 604);
    _pageController = PageController(initialPage: _currentPage - 1);
    _precache(_currentPage);
    _checkBookmarkState(_currentPage);
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _precache(int page) {
    for (var p = (page - 2).clamp(1, 604); p <= (page + 2).clamp(1, 604); p++) {
      ref.read(_pageDataProvider(p));
    }
  }

  void _jumpToPage(int page) {
    final p = page.clamp(1, 604);
    setState(() => _currentPage = p);
    _pageController.jumpToPage(p - 1);
    _precache(p);
    _checkBookmarkState(p);
  }

  void _onPageChanged(int index) {
    final page = index + 1;
    setState(() => _currentPage = page);
    _precache(page);
    _checkBookmarkState(page);
    _scheduleSave(page);
  }

  void _scheduleSave(int page) {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 500), () {
      if (page == _lastSavedPage) return;
      _lastSavedPage = page;
      final pageAsync = ref.read(_pageDataProvider(page));
      pageAsync.whenData((pd) {
        int surahNum = pd.verses.isNotEmpty ? pd.verses.first.surahNumber : 1;
        int ayahNum = pd.verses.isNotEmpty ? pd.verses.first.ayahNumber : 1;
        String surahNameSimple = 'Page $page';
        String surahNameArabic = '';

        final surahsAsync = ref.read(surahsProvider);
        surahsAsync.whenData((surahs) {
          final found = surahs.where((s) => s.number == surahNum);
          if (found.isNotEmpty) {
            surahNameSimple = found.first.nameSimple;
            surahNameArabic = found.first.nameArabic;
          }
        });

        ref.read(readingPositionServiceProvider).saveLastPosition(
          ReadingPosition(
            pageNumber: page,
            surahNumber: surahNum,
            ayahNumber: ayahNum,
            surahNameSimple: surahNameSimple,
            surahNameArabic: surahNameArabic,
            savedAt: DateTime.now(),
          ),
        );

        // Invalidate the last reading position provider so home screen updates
        ref.invalidate(lastReadingPositionProvider);
      });
    });
  }

  void _checkBookmarkState(int page) {
    ref.read(readingPositionServiceProvider).isPageBookmarked(page).then((v) {
      if (mounted) setState(() => _isBookmarked = v);
    });
  }

  void _toggleBookmark() async {
    final pageAsync = ref.read(_pageDataProvider(_currentPage));
    pageAsync.whenData((pd) async {
      int surahNum = pd.verses.isNotEmpty ? pd.verses.first.surahNumber : 1;
      int ayahNum = pd.verses.isNotEmpty ? pd.verses.first.ayahNumber : 1;
      String surahNameSimple = 'Page $_currentPage';
      String surahNameArabic = '';

      final surahsAsync = ref.read(surahsProvider);
      surahsAsync.whenData((surahs) {
        final found = surahs.where((s) => s.number == surahNum);
        if (found.isNotEmpty) {
          surahNameSimple = found.first.nameSimple;
          surahNameArabic = found.first.nameArabic;
        }
      });

      if (_isBookmarked) {
        // Remove bookmark
        final bm = await ref
            .read(readingPositionServiceProvider)
            .getBookmarkForPage(_currentPage);
        if (bm != null) {
          await ref.read(bookmarksProvider.notifier).remove(bm.id);
        }
        setState(() => _isBookmarked = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bookmark removed'),
              duration: Duration(seconds: 2),
              backgroundColor: ItqanColors.charcoal,
            ),
          );
        }
      } else {
        // Add bookmark
        final position = ReadingPosition(
          pageNumber: _currentPage,
          surahNumber: surahNum,
          ayahNumber: ayahNum,
          surahNameSimple: surahNameSimple,
          surahNameArabic: surahNameArabic,
          savedAt: DateTime.now(),
        );
        await ref.read(bookmarksProvider.notifier).add(position);
        setState(() => _isBookmarked = true);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Bookmark saved ✓',
                style: TextStyle(color: ItqanColors.void_, fontWeight: FontWeight.w600),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: ItqanColors.gold,
            ),
          );
        }
      }
    });
  }

  void _showJumpDialog() {
    int temp = _currentPage;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          backgroundColor: ItqanColors.onyx,
          title: const Text('Jump to Page', style: ItqanTypography.label),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: temp.toDouble(),
                min: 1,
                max: 604,
                divisions: 603,
                activeColor: ItqanColors.gold,
                inactiveColor: ItqanColors.charcoal,
                label: 'Page $temp',
                onChanged: (v) => setS(() => temp = v.round()),
              ),
              Text('Page $temp / 604', style: ItqanTypography.caption),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: ItqanColors.mist)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: ItqanColors.gold),
              onPressed: () {
                Navigator.pop(ctx);
                _jumpToPage(temp);
              },
              child: const Text('Go', style: TextStyle(color: ItqanColors.void_)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(_pageDataProvider(_currentPage));

    // Current surah name for bottom bar
    final String surahName = pageAsync.maybeWhen(
      data: (pd) {
        if (pd.verses.isEmpty) return 'Page $_currentPage';
        final s = pd.verses.first.surahNumber;
        final surahsAsync = ref.watch(surahsProvider);
        return surahsAsync.maybeWhen(
          data: (surahs) {
            final found = surahs.where((x) => x.number == s);
            return found.isNotEmpty ? found.first.nameSimple : 'Page $_currentPage';
          },
          orElse: () => 'Page $_currentPage',
        );
      },
      orElse: () => 'Page $_currentPage',
    );

    final int juzNum = pageAsync.maybeWhen(
      data: (pd) => pd.juzNumber,
      orElse: () => 0,
    );

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top info bar ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: const BoxDecoration(
                color: ItqanColors.obsidian,
                border: Border(bottom: BorderSide(color: ItqanColors.charcoal)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: ItqanColors.mist, size: 16),
                    onPressed: () => Navigator.pop(context),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                  juzNum > 0
                      ? Text('Juz $juzNum',
                          style: const TextStyle(color: ItqanColors.mist, fontSize: 11))
                      : const SizedBox.shrink(),
                  Text(
                    surahName,
                    style: const TextStyle(color: ItqanColors.cloud, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bookmark button
                      IconButton(
                        icon: Icon(
                          _isBookmarked
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: _isBookmarked ? ItqanColors.gold : ItqanColors.mist,
                          size: 18,
                        ),
                        onPressed: _toggleBookmark,
                        tooltip: _isBookmarked ? 'Remove bookmark' : 'Add bookmark',
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: 4),
                      // Translation toggle
                      IconButton(
                        icon: Icon(
                          Icons.translate_rounded,
                          color: _showTranslation ? ItqanColors.gold : ItqanColors.mist,
                          size: 18,
                        ),
                        onPressed: () => setState(() => _showTranslation = !_showTranslation),
                        tooltip: 'Translation',
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Page content ──────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                reverse: true, // RTL: right page = earlier
                itemCount: 604,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final page = index + 1;
                  return _MushafPage(
                    pageNumber: page,
                    showTranslation: _showTranslation,
                  );
                },
              ),
            ),

            // ── Bottom nav bar ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: ItqanColors.obsidian,
                border: Border(top: BorderSide(color: ItqanColors.charcoal)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavArrow(
                    icon: Icons.arrow_back_ios_rounded,
                    enabled: _currentPage > 1,
                    onTap: () => _jumpToPage(_currentPage - 1),
                  ),
                  GestureDetector(
                    onTap: _showJumpDialog,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Page $_currentPage',
                          style: const TextStyle(
                            color: ItqanColors.gold,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'of 604  •  tap to jump',
                          style: const TextStyle(color: ItqanColors.mist, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  _NavArrow(
                    icon: Icons.arrow_forward_ios_rounded,
                    enabled: _currentPage < 604,
                    onTap: () => _jumpToPage(_currentPage + 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavArrow({required this.icon, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? ItqanColors.charcoal : ItqanColors.obsidian,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? ItqanColors.silver : ItqanColors.slate,
          size: 16,
        ),
      ),
    );
  }
}

// ─── Single page content widget ───────────────────────────────────────────────

class _MushafPage extends ConsumerWidget {
  final int pageNumber;
  final bool showTranslation;

  const _MushafPage({required this.pageNumber, required this.showTranslation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageAsync = ref.watch(_pageDataProvider(pageNumber));
    final surahsAsync = ref.watch(surahsProvider);

    return pageAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: ItqanColors.gold)),
      error: (err, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: ItqanColors.mist, size: 40),
            const SizedBox(height: 12),
            Text('Could not load page $pageNumber', style: ItqanTypography.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
      data: (pageData) {
        if (pageData.verses.isEmpty) {
          return Center(child: Text('Page $pageNumber', style: ItqanTypography.caption));
        }

        final surahMap = surahsAsync.maybeWhen(
          data: (list) => {for (final s in list) s.number: s},
          orElse: () => <int, Surah>{},
        );

        final groups = <_SurahGroup>[];
        for (final verse in pageData.verses) {
          if (groups.isEmpty || groups.last.surahNumber != verse.surahNumber) {
            groups.add(_SurahGroup(verse.surahNumber, []));
          }
          groups.last.verses.add(verse);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final group in groups) ...[
                if (group.verses.first.isFirstOfSurah) ...[
                  _SurahBanner(
                    surah: surahMap[group.surahNumber],
                    surahNumber: group.surahNumber,
                  ),
                ],
                _VerseBlock(
                  verses: group.verses,
                  showTranslation: showTranslation,
                ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _SurahGroup {
  final int surahNumber;
  final List<VerseOnPage> verses;
  _SurahGroup(this.surahNumber, this.verses);
}

// ─── Surah Banner ─────────────────────────────────────────────────────────────

class _SurahBanner extends StatelessWidget {
  final Surah? surah;
  final int surahNumber;

  const _SurahBanner({required this.surah, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final arabic = surah?.nameArabic ?? '';
    final place = surah?.revelationPlace == 'makkah' ? 'مكية' : 'مدنية';
    final ayahCount = surah?.ayahCount ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: ItqanColors.gold, width: 1),
          bottom: BorderSide(color: ItqanColors.gold, width: 1),
        ),
      ),
      child: Column(
        children: [
          if (arabic.isNotEmpty)
            Text(
              arabic,
              style: const TextStyle(
                fontFamily: 'NotoNaskhArabic',
                fontSize: 28,
                color: ItqanColors.gold,
                height: 1.6,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          if (ayahCount > 0) ...[
            const SizedBox(height: 4),
            Text(
              ayahCount > 0 ? '$place · $ayahCount آيات' : '',
              style: const TextStyle(color: ItqanColors.mist, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
          if (surahNumber != 9 && surahNumber != 1) ...[
            const SizedBox(height: 12),
            const Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              style: TextStyle(
                fontFamily: 'NotoNaskhArabic',
                fontSize: 22,
                color: ItqanColors.goldLight,
                height: 2.0,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Verse Block ─────────────────────────────────────────────────────────────

class _VerseBlock extends ConsumerWidget {
  final List<VerseOnPage> verses;
  final bool showTranslation;

  const _VerseBlock({required this.verses, required this.showTranslation});

  String _toArabicNumerals(int n) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((c) {
      final d = int.tryParse(c);
      return d != null ? digits[d] : c;
    }).join();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spans = <InlineSpan>[];

    for (final verse in verses) {
      spans.add(TextSpan(
        text: verse.textUthmani,
        style: const TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 24,
          height: 2.2,
          color: ItqanColors.snow,
        ),
      ));
      spans.add(TextSpan(
        text: ' \u06DD${_toArabicNumerals(verse.ayahNumber)} ',
        style: const TextStyle(
          fontFamily: 'NotoNaskhArabic',
          fontSize: 18,
          height: 2.2,
          color: ItqanColors.gold,
        ),
      ));
    }

    final column = <Widget>[
      GestureDetector(
        onLongPressStart: (details) => _showWordSheet(context, ref, details),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: spans),
          ),
        ),
      ),
    ];

    if (showTranslation) {
      for (final verse in verses) {
        if (verse.translation.isNotEmpty) {
          column.add(Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${verse.ayahNumber}. ',
                  style: const TextStyle(color: ItqanColors.gold, fontSize: 11),
                ),
                Expanded(
                  child: Text(
                    verse.translation,
                    style: const TextStyle(color: ItqanColors.silver, fontSize: 12, height: 1.6),
                  ),
                ),
              ],
            ),
          ));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: column,
    );
  }

  void _showWordSheet(BuildContext context, WidgetRef ref, LongPressStartDetails details) {
    if (verses.isEmpty) return;
    final verse = verses.first;

    showModalBottomSheet(
      context: context,
      backgroundColor: ItqanColors.onyx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _WordDetailSheet(verse: verse),
    );
  }
}

// ─── Word Detail Bottom Sheet ─────────────────────────────────────────────────

class _WordDetailSheet extends ConsumerWidget {
  final VerseOnPage verse;

  const _WordDetailSheet({required this.verse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: ItqanColors.slate,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            verse.textUthmani,
            style: const TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: 26,
              color: ItqanColors.snow,
              height: 2.0,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Ayah ${verse.ayahNumber} • Surah ${verse.surahNumber}',
            style: ItqanTypography.caption,
            textAlign: TextAlign.center,
          ),
          if (verse.translation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              verse.translation,
              style: const TextStyle(color: ItqanColors.silver, fontSize: 13, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ItqanColors.gold,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                Navigator.pop(context);
                final service = ref.read(quranServiceProvider);
                await service.init();
                final ayahs = await service.getAyahs(verse.surahNumber);
                if (!context.mounted) return;
                final ayah = ayahs.firstWhere(
                  (a) => a.ayahNumber == verse.ayahNumber,
                  orElse: () => ayahs.first,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecitationScreen(
                      ayah: ayah,
                      surahName: 'Surah ${verse.surahNumber}',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.mic_rounded, color: ItqanColors.void_, size: 18),
              label: const Text('Practice this Ayah',
                  style: TextStyle(color: ItqanColors.void_, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
