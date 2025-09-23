import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_models.dart';
import 'app_data.dart';

class UserProgressService extends ChangeNotifier {
  List<Chapter> _chapters = [];
  String _currentTheme = 'golden';
  int _totalXP = 2450;
  int _currentStreak = 7;

  UserProgressService() {
    _initializeProgress();
  }
  List<Chapter> get chapters => _chapters;
  int get completedChapters =>
      _chapters.where((ch) => ch.status == ChapterStatus.completed).length;
  int get currentStreak => _currentStreak;

  String get currentTheme => _currentTheme;

  int get totalXP => _totalXP;

  bool canAccessChapter(int chapterId) {
    final chapter = _chapters.firstWhere((ch) => ch.id == chapterId);
    return chapter.status != ChapterStatus.locked;
  }

  void completeChapter(int chapterId, {int xpGained = 50}) {
    final chapterIndex = _chapters.indexWhere((ch) => ch.id == chapterId);
    if (chapterIndex == -1) return;

    final chapter = _chapters[chapterIndex];
    if (chapter.status != ChapterStatus.current) return;

    // Mark current chapter as completed
    _chapters[chapterIndex] = chapter.copyWith(status: ChapterStatus.completed);

    // Add XP
    _totalXP += xpGained;

    // Update streak (simplified logic)
    _currentStreak++;

    // Unlock next chapter
    _unlockNextChapter(chapter);

    _saveProgress();
    notifyListeners();
  }

void getTheme() {
  
  _loadProgress();
  notifyListeners();
}
  void setTheme(String theme) {
    _currentTheme = theme;
    _saveProgress();
    notifyListeners();
  }

  void _initializeProgress() {
    _chapters = List.from(AppData.initialChapters);
    _loadProgress();
  }

  bool _isChapterUnlocked(Chapter chapter) {
    // First chapter of each book should be unlocked if previous book is completed
    if (chapter.chapterNumber == 1) {
      final previousBook =
          AppData.books.where((b) => b.id < chapter.bookId).lastOrNull;
      if (previousBook == null) return true; // First book

      // Check if previous book is completed
      final previousBookChapters =
          _chapters.where((ch) => ch.bookId == previousBook.id);
      return previousBookChapters
          .every((ch) => ch.status == ChapterStatus.completed);
    }

    // For other chapters, previous chapter should be completed
    final previousChapter = _chapters
        .where((ch) =>
            ch.bookId == chapter.bookId &&
            ch.chapterNumber == chapter.chapterNumber - 1)
        .firstOrNull;
    return previousChapter?.status == ChapterStatus.completed;
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load theme
      _currentTheme = prefs.getString('theme') ?? 'golden';

      // Load XP and streak
      _totalXP = prefs.getInt('totalXP') ?? 2450;
      _currentStreak = prefs.getInt('currentStreak') ?? 7;

      // Load chapter progress
      final completedChapterIds =
          prefs.getStringList('completedChapters') ?? [];
      final currentChapterId = prefs.getInt('currentChapter');

      for (int i = 0; i < _chapters.length; i++) {
        final chapter = _chapters[i];
        if (completedChapterIds.contains(chapter.id.toString())) {
          _chapters[i] = chapter.copyWith(status: ChapterStatus.completed);
        } else if (chapter.id == currentChapterId) {
          _chapters[i] = chapter.copyWith(status: ChapterStatus.current);
        } else if (_isChapterUnlocked(chapter)) {
          _chapters[i] = chapter.copyWith(status: ChapterStatus.current);
        } else {
          _chapters[i] = chapter.copyWith(status: ChapterStatus.locked);
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading progress: $e');
    }
  }

  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save theme
      await prefs.setString('theme', _currentTheme);

      // Save XP and streak
      await prefs.setInt('totalXP', _totalXP);
      await prefs.setInt('currentStreak', _currentStreak);

      // Save chapter progress
      final completedChapterIds = _chapters
          .where((ch) => ch.status == ChapterStatus.completed)
          .map((ch) => ch.id.toString())
          .toList();
      await prefs.setStringList('completedChapters', completedChapterIds);

      final currentChapter = _chapters.firstWhere(
        (ch) => ch.status == ChapterStatus.current,
        orElse: () => _chapters.first,
      );
      await prefs.setInt('currentChapter', currentChapter.id);
    } catch (e) {
      debugPrint('Error saving progress: $e');
    }
  }

  void _unlockNextChapter(Chapter completedChapter) {
    // Find next chapter in the same book
    final nextChapterInBook = _chapters
        .where((ch) =>
            ch.bookId == completedChapter.bookId &&
            ch.chapterNumber == completedChapter.chapterNumber + 1)
        .firstOrNull;

    if (nextChapterInBook != null) {
      final index = _chapters.indexWhere((ch) => ch.id == nextChapterInBook.id);
      _chapters[index] =
          nextChapterInBook.copyWith(status: ChapterStatus.current);
      return;
    }

    // If no more chapters in current book, unlock first chapter of next book
    final nextBook =
        AppData.books.where((b) => b.id > completedChapter.bookId).firstOrNull;
    if (nextBook != null) {
      final firstChapterOfNextBook = _chapters
          .where((ch) => ch.bookId == nextBook.id && ch.chapterNumber == 1)
          .firstOrNull;
      if (firstChapterOfNextBook != null) {
        final index =
            _chapters.indexWhere((ch) => ch.id == firstChapterOfNextBook.id);
        _chapters[index] =
            firstChapterOfNextBook.copyWith(status: ChapterStatus.current);
      }
    }
  }
}
