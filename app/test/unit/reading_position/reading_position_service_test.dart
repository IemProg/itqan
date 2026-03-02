import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itqan/features/mushaf/services/reading_position_service.dart';

void main() {
  late Directory tempDir;
  late ReadingPositionService service;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    await Hive.openBox(ReadingPositionService.boxKey);
    service = ReadingPositionService();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk(ReadingPositionService.boxKey);
    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });

  ReadingPosition _pos({int page = 55, int surah = 2, int ayah = 142, String name = 'Al-Baqarah'}) =>
      ReadingPosition(
        pageNumber: page,
        surahNumber: surah,
        ayahNumber: ayah,
        surahNameSimple: name,
        savedAt: DateTime(2024, 1, 1, 12),
      );

  group('ReadingPositionService', () {
    test('returns null when no position saved', () async {
      final pos = await service.getLastPosition();
      expect(pos, isNull);
    });

    test('saves and retrieves last position correctly', () async {
      final original = _pos();
      await service.saveLastPosition(original);
      final retrieved = await service.getLastPosition();
      expect(retrieved, isNotNull);
      expect(retrieved!.pageNumber, equals(55));
      expect(retrieved.surahNumber, equals(2));
      expect(retrieved.ayahNumber, equals(142));
      expect(retrieved.surahNameSimple, equals('Al-Baqarah'));
    });

    test('overwrites last position on second save', () async {
      await service.saveLastPosition(_pos(page: 10));
      await service.saveLastPosition(_pos(page: 99));
      final pos = await service.getLastPosition();
      expect(pos!.pageNumber, equals(99));
    });

    test('addBookmark creates a new bookmark', () async {
      await service.addBookmark(_pos(), label: 'My spot');
      final bookmarks = await service.getBookmarks();
      expect(bookmarks.length, equals(1));
      expect(bookmarks.first.label, equals('My spot'));
      expect(bookmarks.first.pageNumber, equals(55));
    });

    test('getBookmarks returns all bookmarks sorted by date', () async {
      final older = ReadingPosition(
        pageNumber: 1, surahNumber: 1, ayahNumber: 1,
        surahNameSimple: 'Al-Fatiha',
        savedAt: DateTime(2024, 1, 1),
      );
      final newer = ReadingPosition(
        pageNumber: 100, surahNumber: 4, ayahNumber: 1,
        surahNameSimple: 'An-Nisa',
        savedAt: DateTime(2024, 3, 1),
      );
      await service.addBookmark(older);
      await service.addBookmark(newer);
      final bookmarks = await service.getBookmarks();
      expect(bookmarks.length, equals(2));
      // Newest first
      expect(bookmarks.first.pageNumber, equals(100));
      expect(bookmarks.last.pageNumber, equals(1));
    });

    test('removeBookmark deletes by id', () async {
      await service.addBookmark(_pos());
      final bookmarks = await service.getBookmarks();
      expect(bookmarks.length, equals(1));
      await service.removeBookmark(bookmarks.first.id);
      final after = await service.getBookmarks();
      expect(after, isEmpty);
    });

    test('clearLastPosition removes last read key', () async {
      await service.saveLastPosition(_pos());
      await service.clearLastPosition();
      final pos = await service.getLastPosition();
      expect(pos, isNull);
    });
  });

  group('Relative timestamp helper', () {
    test('"just now" for < 1 minute ago', () {
      final t = DateTime.now().subtract(const Duration(seconds: 30));
      expect(relativeTimestamp(t), equals('just now'));
    });

    test('"X minutes ago" for < 1 hour', () {
      final t = DateTime.now().subtract(const Duration(minutes: 5));
      expect(relativeTimestamp(t), equals('5 minutes ago'));
    });

    test('"X hours ago" for < 24 hours', () {
      final t = DateTime.now().subtract(const Duration(hours: 3));
      expect(relativeTimestamp(t), equals('3 hours ago'));
    });

    test('"yesterday" for ~24 hours ago', () {
      final t = DateTime.now().subtract(const Duration(hours: 25));
      expect(relativeTimestamp(t), equals('yesterday'));
    });

    test('"X days ago" for > 1 day', () {
      final t = DateTime.now().subtract(const Duration(days: 3));
      expect(relativeTimestamp(t), contains('days ago'));
    });
  });
}
