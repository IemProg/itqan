import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/reading_position_service.dart';

final readingPositionServiceProvider = Provider<ReadingPositionService>(
  (ref) => ReadingPositionService(),
);

final lastReadingPositionProvider = FutureProvider<ReadingPosition?>((ref) async {
  return ref.read(readingPositionServiceProvider).getLastPosition();
});

// ─── Bookmarks Notifier ───────────────────────────────────────────────────────

class BookmarksNotifier extends StateNotifier<List<BookmarkedPosition>> {
  final ReadingPositionService _service;

  BookmarksNotifier(this._service) : super([]) {
    load();
  }

  Future<void> load() async {
    state = await _service.getBookmarks();
  }

  Future<void> add(ReadingPosition position, {String? label}) async {
    await _service.addBookmark(position, label: label);
    state = await _service.getBookmarks();
  }

  Future<void> remove(String id) async {
    await _service.removeBookmark(id);
    state = state.where((b) => b.id != id).toList();
  }

  bool isPageBookmarked(int pageNumber) {
    return state.any((b) => b.pageNumber == pageNumber);
  }

  BookmarkedPosition? getBookmarkForPage(int pageNumber) {
    try {
      return state.firstWhere((b) => b.pageNumber == pageNumber);
    } catch (_) {
      return null;
    }
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<BookmarkedPosition>>((ref) {
  return BookmarksNotifier(ref.read(readingPositionServiceProvider));
});
