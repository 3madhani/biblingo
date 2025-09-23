import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../services/app_data.dart';
import 'book_divider.dart';
import 'chapter_node.dart';

class LearningPath extends StatelessWidget {
  final List<Chapter> chapters;
  final Function(int) onChapterClick;

  const LearningPath({
    super.key,
    required this.chapters,
    required this.onChapterClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: _buildPathElements(),
        ),
      ),
    );
  }

  List<Widget> _buildPathElements() {
    final List<Widget> elements = [];
    final groupedChapters = <int, List<Chapter>>{};

    // Group chapters by book
    for (final chapter in chapters) {
      groupedChapters.putIfAbsent(chapter.bookId, () => []).add(chapter);
    }

    // Build path elements for each book
    for (final book in AppData.books) {
      final bookChapters = groupedChapters[book.id] ?? [];
      if (bookChapters.isEmpty) continue;

      // Add book divider
      final completedInBook = bookChapters
          .where((ch) => ch.status == ChapterStatus.completed)
          .length;
      elements.add(
        BookDivider(
          book: book,
          completedChapters: completedInBook,
          totalChapters: _getTotalChaptersForBook(book.id),
        ),
      );

      // Add chapter nodes for this book
      for (int i = 0; i < bookChapters.length; i++) {
        final chapter = bookChapters[i];
        final isAlternate = i % 2 == 1;

        elements.add(
          ChapterNode(
            chapter: chapter,
            book: book,
            isAlternatePosition: isAlternate,
            onTap: () => onChapterClick(chapter.id),
          ),
        );
      }

      // Add spacing between books
      elements.add(const SizedBox(height: 40));
    }

    // Add bottom padding for navigation
    elements.add(const SizedBox(height: 100));

    return elements;
  }

  int _getTotalChaptersForBook(int bookId) {
    // This would normally come from a database or API
    // For now, using sample data
    const totalChapters = {
      1: 50, // سفر التكوين
      2: 40, // سفر الخروج
      3: 27, // سفر اللاويين
      4: 36, // سفر العدد
      5: 34, // سفر التثنية
      6: 24, // سفر يشوع
    };

    return totalChapters[bookId] ?? 25;
  }
}
