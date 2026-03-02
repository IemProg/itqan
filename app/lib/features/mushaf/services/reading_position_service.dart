import 'package:hive_flutter/hive_flutter.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class ReadingPosition {
  final int pageNumber;
  final int surahNumber;
  final int ayahNumber;
  final String surahNameSimple;
  final String surahNameArabic;
  final DateTime savedAt;

  const ReadingPosition({
    required this.pageNumber,
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahNameSimple,
    this.surahNameArabic = '',
    required this.savedAt,
  });

  Map<String, dynamic> toMap() => {
    'pageNumber': pageNumber,
    'surahNumber': surahNumber,
    'ayahNumber': ayahNumber,
    'surahNameSimple': surahNameSimple,
    'surahNameArabic': surahNameArabic,
    'savedAt': savedAt.toIso8601String(),
  };

  factory ReadingPosition.fromMap(Map<dynamic, dynamic> map) => ReadingPosition(
    pageNumber: (map['pageNumber'] as num).toInt(),
    surahNumber: (map['surahNumber'] as num).toInt(),
    ayahNumber: (map['ayahNumber'] as num).toInt(),
    surahNameSimple: map['surahNameSimple'] as String? ?? '',
    surahNameArabic: map['surahNameArabic'] as String? ?? '',
    savedAt: DateTime.parse(map['savedAt'] as String),
  );
}

class BookmarkedPosition extends ReadingPosition {
  final String id;
  final String? label;

  const BookmarkedPosition({
    required this.id,
    this.label,
    required super.pageNumber,
    required super.surahNumber,
    required super.ayahNumber,
    required super.surahNameSimple,
    super.surahNameArabic,
    required super.savedAt,
  });

  @override
  Map<String, dynamic> toMap() => {
    ...super.toMap(),
    'id': id,
    'label': label,
  };

  factory BookmarkedPosition.fromMap(Map<dynamic, dynamic> map) => BookmarkedPosition(
    id: map['id'] as String,
    label: map['label'] as String?,
    pageNumber: (map['pageNumber'] as num).toInt(),
    surahNumber: (map['surahNumber'] as num).toInt(),
    ayahNumber: (map['ayahNumber'] as num).toInt(),
    surahNameSimple: map['surahNameSimple'] as String? ?? '',
    surahNameArabic: map['surahNameArabic'] as String? ?? '',
    savedAt: DateTime.parse(map['savedAt'] as String),
  );
}

// ─── Service ──────────────────────────────────────────────────────────────────

class ReadingPositionService {
  static const boxKey = 'reading_positions';
  static const lastReadKey = 'last_read';
  static const bookmarksKey = 'bookmarks';

  Box get _box => Hive.box(boxKey);

  Future<void> saveLastPosition(ReadingPosition position) async {
    await _box.put(lastReadKey, position.toMap());
  }

  Future<ReadingPosition?> getLastPosition() async {
    final raw = _box.get(lastReadKey);
    if (raw == null) return null;
    return ReadingPosition.fromMap(raw as Map);
  }

  Future<void> clearLastPosition() async {
    await _box.delete(lastReadKey);
  }

  Future<void> addBookmark(ReadingPosition position, {String? label}) async {
    final bookmarks = await getBookmarks();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final bm = BookmarkedPosition(
      id: id,
      label: label,
      pageNumber: position.pageNumber,
      surahNumber: position.surahNumber,
      ayahNumber: position.ayahNumber,
      surahNameSimple: position.surahNameSimple,
      surahNameArabic: position.surahNameArabic,
      savedAt: position.savedAt,
    );
    bookmarks.add(bm);
    await _box.put(bookmarksKey, bookmarks.map((b) => b.toMap()).toList());
  }

  Future<List<BookmarkedPosition>> getBookmarks() async {
    final raw = _box.get(bookmarksKey);
    if (raw == null) return [];
    final list = raw as List;
    final result = list.map((e) => BookmarkedPosition.fromMap(e as Map)).toList();
    result.sort((a, b) => b.savedAt.compareTo(a.savedAt));
    return result;
  }

  Future<void> removeBookmark(String id) async {
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((b) => b.id == id);
    await _box.put(bookmarksKey, bookmarks.map((b) => b.toMap()).toList());
  }

  Future<bool> isPageBookmarked(int pageNumber) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((b) => b.pageNumber == pageNumber);
  }

  Future<BookmarkedPosition?> getBookmarkForPage(int pageNumber) async {
    final bookmarks = await getBookmarks();
    try {
      return bookmarks.firstWhere((b) => b.pageNumber == pageNumber);
    } catch (_) {
      return null;
    }
  }
}

// ─── Relative Timestamp Helper ────────────────────────────────────────────────

String relativeTimestamp(DateTime dateTime) {
  final diff = DateTime.now().difference(dateTime);
  if (diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) {
    final m = diff.inMinutes;
    return '$m minutes ago';
  }
  if (diff.inHours < 24) {
    final h = diff.inHours;
    return '$h hours ago';
  }
  if (diff.inHours < 48) return 'yesterday';
  final d = diff.inDays;
  return '$d days ago';
}

// Localized version — requires BuildContext (available in widget build methods)
String localizedRelativeTimestamp(dynamic context, DateTime dateTime) {
  try {
    // ignore: avoid_dynamic_calls
    final l10n = context.l10n as dynamic;
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return l10n.timeJustNow as String;
    if (diff.inMinutes < 60) return (l10n.timeMinutesAgo(diff.inMinutes)) as String;
    if (diff.inHours < 24) return (l10n.timeHoursAgo(diff.inHours)) as String;
    if (diff.inHours < 48) return l10n.timeYesterday as String;
    return (l10n.timeDaysAgo(diff.inDays)) as String;
  } catch (_) {
    return relativeTimestamp(dateTime);
  }
}
