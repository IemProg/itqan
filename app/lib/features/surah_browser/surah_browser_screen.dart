import 'package:flutter/material.dart';
import 'package:itqan/l10n/app_localizations.dart';
import '../../core/extensions/context_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../quran/models/ayah.dart';
import '../mushaf/mushaf_screen.dart'; // for providers
import '../mushaf/mushaf_page_screen.dart';
import '../recitation/recitation_screen.dart';

// Juz metadata: starting surah name + ayah for each juz (1-indexed)
const _juzData = [
  {'name': 'Al-Fatihah', 'surah': 1, 'ayah': 1, 'page': 1},
  {'name': 'Al-Baqarah', 'surah': 2, 'ayah': 142, 'page': 22},
  {'name': 'Al-Baqarah', 'surah': 2, 'ayah': 253, 'page': 42},
  {'name': "Ali 'Imran", 'surah': 3, 'ayah': 92, 'page': 62},
  {'name': 'An-Nisa', 'surah': 4, 'ayah': 24, 'page': 82},
  {'name': 'An-Nisa', 'surah': 4, 'ayah': 148, 'page': 102},
  {'name': "Al-Ma'idah", 'surah': 5, 'ayah': 82, 'page': 121},
  {'name': "Al-An'am", 'surah': 6, 'ayah': 111, 'page': 142},
  {'name': "Al-A'raf", 'surah': 7, 'ayah': 87, 'page': 162},
  {'name': 'Al-Anfal', 'surah': 8, 'ayah': 41, 'page': 182},
  {'name': 'At-Tawbah', 'surah': 9, 'ayah': 93, 'page': 201},
  {'name': 'Hud', 'surah': 11, 'ayah': 6, 'page': 221},
  {'name': 'Yusuf', 'surah': 12, 'ayah': 53, 'page': 241},
  {'name': 'Al-Hijr', 'surah': 15, 'ayah': 1, 'page': 262},
  {'name': 'Al-Isra', 'surah': 17, 'ayah': 1, 'page': 282},
  {'name': 'Al-Kahf', 'surah': 18, 'ayah': 75, 'page': 302},
  {'name': 'Al-Anbiya', 'surah': 21, 'ayah': 1, 'page': 322},
  {'name': "Al-Mu'minun", 'surah': 23, 'ayah': 1, 'page': 342},
  {'name': 'Al-Furqan', 'surah': 25, 'ayah': 21, 'page': 362},
  {'name': 'An-Naml', 'surah': 27, 'ayah': 56, 'page': 382},
  {'name': 'Al-Ankabut', 'surah': 29, 'ayah': 46, 'page': 402},
  {'name': 'Al-Ahzab', 'surah': 33, 'ayah': 31, 'page': 422},
  {'name': 'Ya-Sin', 'surah': 36, 'ayah': 28, 'page': 442},
  {'name': 'Az-Zumar', 'surah': 39, 'ayah': 32, 'page': 462},
  {'name': 'Fussilat', 'surah': 41, 'ayah': 47, 'page': 482},
  {'name': 'Al-Ahqaf', 'surah': 46, 'ayah': 1, 'page': 502},
  {'name': 'Adh-Dhariyat', 'surah': 51, 'ayah': 31, 'page': 522},
  {'name': 'Al-Mujadila', 'surah': 58, 'ayah': 1, 'page': 542},
  {'name': 'Al-Mulk', 'surah': 67, 'ayah': 1, 'page': 562},
  {'name': "An-Naba'", 'surah': 78, 'ayah': 1, 'page': 582},
];

// Approximate first page for each surah
const _surahFirstPage = <int, int>{
  1: 1, 2: 2, 3: 50, 4: 77, 5: 106, 6: 128, 7: 151, 8: 177, 9: 187,
  10: 208, 11: 221, 12: 235, 13: 249, 14: 255, 15: 262, 16: 267, 17: 282,
  18: 293, 19: 305, 20: 312, 21: 322, 22: 333, 23: 342, 24: 350, 25: 359,
  26: 367, 27: 377, 28: 385, 29: 396, 30: 404, 31: 411, 32: 415, 33: 418,
  34: 428, 35: 434, 36: 440, 37: 446, 38: 453, 39: 458, 40: 467, 41: 477,
  42: 483, 43: 489, 44: 496, 45: 499, 46: 502, 47: 507, 48: 511, 49: 515,
  50: 518, 51: 520, 52: 523, 53: 526, 54: 528, 55: 531, 56: 534, 57: 537,
  58: 542, 59: 545, 60: 549, 61: 551, 62: 553, 63: 554, 64: 556, 65: 558,
  66: 560, 67: 562, 68: 564, 69: 566, 70: 568, 71: 570, 72: 572, 73: 574,
  74: 575, 75: 577, 76: 578, 77: 580, 78: 582, 79: 583, 80: 585, 81: 586,
  82: 587, 83: 587, 84: 589, 85: 590, 86: 591, 87: 591, 88: 592, 89: 593,
  90: 594, 91: 595, 92: 595, 93: 596, 94: 596, 95: 597, 96: 597, 97: 598,
  98: 598, 99: 599, 100: 599, 101: 600, 102: 600, 103: 601, 104: 601,
  105: 601, 106: 602, 107: 602, 108: 602, 109: 603, 110: 603, 111: 603,
  112: 604, 113: 604, 114: 604,
};

class SurahBrowserScreen extends ConsumerStatefulWidget {
  const SurahBrowserScreen({super.key});

  @override
  ConsumerState<SurahBrowserScreen> createState() => _SurahBrowserScreenState();
}

class _SurahBrowserScreenState extends ConsumerState<SurahBrowserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        backgroundColor: ItqanColors.void_,
        title: Text(AppLocalizations.of(context)!.quranTitle, style: ItqanTypography.heading2),
        bottom: TabBar(
          controller: _tabController,
          labelColor: ItqanColors.gold,
          unselectedLabelColor: ItqanColors.mist,
          indicatorColor: ItqanColors.gold,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.quranSurahsTab),
            Tab(text: AppLocalizations.of(context)!.quranJuzTab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SurahsTab(
            query: _query,
            searchController: _searchController,
            onSearch: (q) => setState(() => _query = q),
          ),
          const _JuzTab(),
        ],
      ),
    );
  }
}

class _SurahsTab extends ConsumerWidget {
  final String query;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  const _SurahsTab({
    required this.query,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(surahsProvider);

    return surahsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: ItqanColors.gold)),
      error: (err, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: ItqanColors.mist, size: 48),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.errorLoadFailed, style: ItqanTypography.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(surahsProvider),
              child: Text(AppLocalizations.of(context)!.errorRetry),
            ),
          ],
        ),
      ),
      data: (surahs) {
        final filtered = query.isEmpty
            ? surahs
            : surahs.where((s) {
                final q = query.toLowerCase();
                return s.nameSimple.toLowerCase().contains(q) ||
                    s.nameTranslation.toLowerCase().contains(q) ||
                    s.number.toString().contains(q);
              }).toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: searchController,
                onChanged: onSearch,
                style: const TextStyle(color: ItqanColors.snow, fontSize: 14),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.quranSearchHint,
                  hintStyle: const TextStyle(color: ItqanColors.mist, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: ItqanColors.mist, size: 20),
                  filled: true,
                  fillColor: ItqanColors.onyx,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(
                  color: ItqanColors.charcoal,
                  height: 1,
                  indent: 72,
                ),
                itemBuilder: (context, i) => _SurahRow(surah: filtered[i]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SurahRow extends ConsumerWidget {
  final Surah surah;
  const _SurahRow({required this.surah});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final place = surah.revelationPlace == 'makkah' ? l10n.quranMakki : l10n.quranMadani;

    return ListTile(
      onTap: () => _openMushaf(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          color: ItqanColors.goldShimmer,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          surah.number.toString(),
          style: const TextStyle(
            color: ItqanColors.gold,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surah.nameSimple, style: ItqanTypography.label),
                Text(
                  '$place • ${surah.ayahCount} Ayahs',
                  style: ItqanTypography.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            surah.nameArabic,
            style: const TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: 20,
              color: ItqanColors.goldLight,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconBtn(
            icon: Icons.menu_book_rounded,
            color: ItqanColors.gold,
            tooltip: AppLocalizations.of(context)!.quranReadBtn,
            onTap: () => _openMushaf(context),
          ),
          const SizedBox(width: 4),
          _IconBtn(
            icon: Icons.mic_rounded,
            color: ItqanColors.mist,
            tooltip: AppLocalizations.of(context)!.quranPracticeBtn,
            onTap: () => _openPractice(context, ref),
          ),
        ],
      ),
    );
  }

  void _openMushaf(BuildContext context) {
    final page = _surahFirstPage[surah.number] ?? 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MushafPageScreen(startPage: page)),
    );
  }

  Future<void> _openPractice(BuildContext context, WidgetRef ref) async {
    final service = ref.read(quranServiceProvider);
    await service.init();
    final ayahs = await service.getAyahs(surah.number);
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecitationScreen(ayah: ayahs.first, surahName: surah.nameSimple),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _IconBtn({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: ItqanColors.charcoal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
      ),
    );
  }
}

class _JuzTab extends StatelessWidget {
  const _JuzTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 30,
      separatorBuilder: (_, __) => const Divider(
        color: ItqanColors.charcoal,
        height: 1,
        indent: 72,
      ),
      itemBuilder: (context, i) {
        final juz = _juzData[i];
        final juzNum = i + 1;
        return ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MushafPageScreen(startPage: juz['page'] as int),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: ItqanColors.goldShimmer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$juzNum',
              style: const TextStyle(
                color: ItqanColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          title: Text(AppLocalizations.of(context)!.quranJuzLabel(juzNum), style: ItqanTypography.label),
          subtitle: Text(
            '${juz['name']} : ${juz['ayah']}',
            style: ItqanTypography.caption,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ItqanColors.mist,
            size: 14,
          ),
        );
      },
    );
  }
}
