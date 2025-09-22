import 'package:flutter/material.dart';

import '../models/app_models.dart';
import 'book_divider.dart';
import 'chapter_node.dart';

class LearningPath extends StatelessWidget {
  final List<Chapter> chapters;
  final List<Book> books;
  final Function(int) onChapterTap;

  const LearningPath({
    super.key,
    required this.chapters,
    required this.books,
    required this.onChapterTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 120, // Space for floating navigation
          left: 16,
          right: 16,
        ),
        child: Column(
          children: _buildPathElements(),
        ),
      ),
    );
  }

  List<Widget> _buildPathElements() {
    List<Widget> elements = [];
    int? currentBookId;
    bool isFirstNode = true;

    for (int i = 0; i < chapters.length; i++) {
      final chapter = chapters[i];
      final book = books.firstWhere((b) => b.id == chapter.bookId);

      // Add book divider when switching to a new book
      if (currentBookId != chapter.bookId) {
        if (!isFirstNode) {
          elements.add(const SizedBox(height: 20));
        }
        elements.add(BookDivider(book: book));
        elements.add(const SizedBox(height: 30));
        currentBookId = chapter.bookId;
      }

      // Add connecting path line (except for first node)
      if (!isFirstNode) {
        elements.add(_buildPathLine());
      }

      // Add chapter node
      elements.add(
        Center(
          child: ChapterNode(
            chapter: chapter,
            book: book,
            onTap: () => onChapterTap(chapter.id),
          ),
        ),
      );

      isFirstNode = false;
    }

    return elements;
  }

  Widget _buildPathLine() {
    return Container(
      height: 40,
      width: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[300]!,
            Colors.grey[400]!,
            Colors.grey[300]!,
          ],
        ),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(1, 0),
          ),
        ],
      ),
    );
  }
}
