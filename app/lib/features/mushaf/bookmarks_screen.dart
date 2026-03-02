import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import 'mushaf_page_screen.dart';
import 'providers/reading_position_provider.dart';
import 'services/reading_position_service.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        backgroundColor: ItqanColors.void_,
        title: Row(
          children: [
            const Text('Bookmarks', style: ItqanTypography.heading2),
            if (bookmarks.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: ItqanColors.goldShimmer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ItqanColors.goldGlow),
                ),
                child: Text(
                  '${bookmarks.length}',
                  style: const TextStyle(
                    color: ItqanColors.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      body: bookmarks.isEmpty ? _emptyState() : _bookmarkList(context, ref, bookmarks),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(ItqanSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border_rounded, color: ItqanColors.mist, size: 64),
            SizedBox(height: ItqanSpacing.md),
            Text('No bookmarks yet', style: ItqanTypography.heading2, textAlign: TextAlign.center),
            SizedBox(height: ItqanSpacing.sm),
            Text(
              'Tap ⊕ while reading to save your place',
              style: ItqanTypography.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookmarkList(
    BuildContext context,
    WidgetRef ref,
    List<BookmarkedPosition> bookmarks,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      itemCount: bookmarks.length,
      separatorBuilder: (_, __) => const SizedBox(height: ItqanSpacing.sm),
      itemBuilder: (context, index) {
        final bm = bookmarks[index];
        return _BookmarkTile(bookmark: bm);
      },
    );
  }
}

class _BookmarkTile extends ConsumerWidget {
  final BookmarkedPosition bookmark;
  const _BookmarkTile({required this.bookmark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = bookmark.label ?? 'Page ${bookmark.pageNumber}';

    return Dismissible(
      key: Key(bookmark.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: ItqanSpacing.lg),
        decoration: BoxDecoration(
          color: ItqanColors.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(ItqanRadius.lg),
        ),
        child: const Icon(Icons.delete_rounded, color: ItqanColors.error),
      ),
      onDismissed: (_) {
        ref.read(bookmarksProvider.notifier).remove(bookmark.id);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MushafPageScreen(startPage: bookmark.pageNumber),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(ItqanSpacing.md),
          decoration: BoxDecoration(
            color: ItqanColors.onyx,
            borderRadius: BorderRadius.circular(ItqanRadius.lg),
            border: Border.all(color: ItqanColors.charcoal),
          ),
          child: Row(
            children: [
              const Icon(Icons.bookmark_rounded, color: ItqanColors.gold, size: 20),
              const SizedBox(width: ItqanSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: ItqanTypography.label.copyWith(color: ItqanColors.snow)),
                    const SizedBox(height: 2),
                    if (bookmark.surahNameArabic.isNotEmpty)
                      Text(
                        bookmark.surahNameArabic,
                        style: const TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: 14,
                          color: ItqanColors.goldLight,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    Text(
                      '${bookmark.surahNameSimple} · Ayah ${bookmark.ayahNumber}',
                      style: ItqanTypography.caption,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved ${relativeTimestamp(bookmark.savedAt)}',
                      style: const TextStyle(color: ItqanColors.slate, fontSize: 11),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ItqanColors.goldShimmer,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: ItqanColors.gold),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MushafPageScreen(startPage: bookmark.pageNumber),
                    ),
                  );
                },
                child: const Text('Go',
                    style: TextStyle(color: ItqanColors.gold, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
