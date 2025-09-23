import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class ChapterNode extends StatelessWidget {
  final Chapter chapter;
  final Book book;
  final VoidCallback? onTap;
  final bool isAlternatePosition;

  const ChapterNode({
    super.key,
    required this.chapter,
    required this.book,
    this.onTap,
    this.isAlternatePosition = false,
  });

  @override
  Widget build(BuildContext context) {
    final canAccess = chapter.status != ChapterStatus.locked;

    final node = AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _getNodeGradient(),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          // 🌑 Dark shadow bottom-right
          BoxShadow(
            color: _getShadowColor().withOpacity(0.6),
            offset: const Offset(0, 0),
            blurRadius: 18,
            spreadRadius: 2,
          ),
          // 🔥 Glow effect stronger for current node
          if (chapter.status == ChapterStatus.current)
            BoxShadow(
              color: AppColors.current.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 12,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Center(child: _buildNodeIcon()),
    );

    // ✅ Animate only if current
    final animatedNode = chapter.status == ChapterStatus.current
        ? node
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .scale(
              duration: 800.ms,
              begin: const Offset(1, 1),
              end: const Offset(1.1, 1.1),
              curve: Curves.easeInOut,
            )
            .then()
            .scale(
              duration: 800.ms,
              begin: const Offset(1.1, 1.1),
              end: const Offset(1, 1),
              curve: Curves.easeInOut,
            )
        : node;

    return Padding(
      padding: EdgeInsets.only(
        left: isAlternatePosition ? 60 : 20,
        right: isAlternatePosition ? 20 : 60,
        bottom: 30,
      ),
      child: GestureDetector(
        onTap: canAccess ? onTap : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Node circle (with or without animation)
            animatedNode
                .animate(delay: (chapter.chapterNumber * 80).ms)
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 8),

            // Chapter badge
            Text(
              'الإصحاح ${chapter.chapterNumber}',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            )
                .animate(delay: (chapter.chapterNumber * 100).ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }

  /// Build the icon depending on chapter status
  Widget _buildNodeIcon() {
    switch (chapter.status) {
      case ChapterStatus.completed:
        return const Icon(Icons.check_rounded, color: Colors.white, size: 32);

      case ChapterStatus.current:
        return Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.star, color: AppColors.current, size: 8),
              ),
            ),
          ],
        );

      case ChapterStatus.locked:
        return const Icon(Icons.lock_rounded, color: Colors.white, size: 24);
    }
  }

  /// Gradient depending on chapter status
  LinearGradient _getNodeGradient() {
    switch (chapter.status) {
      case ChapterStatus.completed:
        return LinearGradient(
          colors: AppColors.bookGradients[book.colorKey]!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case ChapterStatus.current:
        return const LinearGradient(
          colors: [AppColors.current, AppColors.goldSecondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case ChapterStatus.locked:
        return LinearGradient(
          colors: [AppColors.locked, AppColors.locked.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  /// Shadow color depending on chapter status
  Color _getShadowColor() {
    switch (chapter.status) {
      case ChapterStatus.completed:
        return AppColors.bookGradients[book.colorKey]!.last;
      case ChapterStatus.current:
        return AppColors.current;
      case ChapterStatus.locked:
        return AppColors.locked;
    }
  }
}
