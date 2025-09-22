import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class ChapterNode extends StatefulWidget {
  final Chapter chapter;
  final Book book;
  final VoidCallback? onTap;

  const ChapterNode({
    super.key,
    required this.chapter,
    required this.book,
    this.onTap,
  });

  @override
  State<ChapterNode> createState() => _ChapterNodeState();
}

class _ChapterNodeState extends State<ChapterNode>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late AnimationController _glowController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  Widget build(BuildContext context) {
    final bookColors = AppColors.bookColors[widget.book.id];
    final statusColor = _getStatusColor();
    final isLocked = widget.chapter.status == ChapterStatus.locked;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _bounceAnimation.value,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Floating particles for current chapter
                  _buildFloatingParticles(),

                  // Main node container with 3D effect
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: isLocked
                            ? [
                                AppColors.locked.withOpacity(0.3),
                                AppColors.locked.withOpacity(0.1),
                              ]
                            : [
                                statusColor,
                                statusColor.withOpacity(0.7),
                              ],
                        stops: const [0.0, 1.0],
                      ),
                      boxShadow: [
                        // Outer glow
                        BoxShadow(
                          color: statusColor.withOpacity(
                              widget.chapter.status == ChapterStatus.current
                                  ? 0.4
                                  : 0.2),
                          blurRadius:
                              widget.chapter.status == ChapterStatus.current
                                  ? 20
                                  : 8,
                          spreadRadius:
                              widget.chapter.status == ChapterStatus.current
                                  ? 4
                                  : 2,
                        ),
                        // Inner depth shadow
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Shine effect overlay
                        if (!isLocked)
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.3, 1.0],
                              ),
                            ),
                          ),

                        // Book icon with enhanced 3D effect
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Icon shadow
                            Transform.translate(
                              offset: const Offset(1, 1),
                              child: Icon(
                                _getStatusIcon(),
                                size: 28,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),

                            // Main icon with glow
                            AnimatedBuilder(
                              animation:
                                  widget.chapter.status == ChapterStatus.current
                                      ? _glowAnimation
                                      : const AlwaysStoppedAnimation(1.0),
                              builder: (context, child) {
                                return Icon(
                                  _getStatusIcon(),
                                  size: 28,
                                  color: isLocked
                                      ? Colors.grey[400]
                                      : Colors.white,
                                  shadows: widget.chapter.status ==
                                          ChapterStatus.current
                                      ? [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(
                                                _glowAnimation.value * 0.8),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                          ),
                                        ]
                                      : [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Chapter number badge
                  Positioned(
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isLocked ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isLocked ? Colors.grey[400]! : statusColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'الإصحاح ${widget.chapter.chapterNumber}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isLocked ? Colors.grey[600] : statusColor,
                          fontFamily: 'Cairo',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),

                  // Progress indicator for current chapter
                  if (widget.chapter.status == ChapterStatus.current)
                    Positioned(
                      top: -8,
                      child: AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _glowAnimation.value,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.8),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Bounce animation for interactions
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
    ));

    // Rotation animation for current chapter
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Glow animation for current chapter
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _glowAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    // Start animations for current chapter
    if (widget.chapter.status == ChapterStatus.current) {
      _rotationController.repeat();
      _glowController.repeat(reverse: true);
    }
  }

  Widget _buildFloatingParticles() {
    if (widget.chapter.status != ChapterStatus.current) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: List.generate(6, (index) {
        final angle = (index * 60.0) * (math.pi / 180);
        const radius = 45.0;

        return AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            final currentAngle = angle + _rotationAnimation.value;
            final x = radius * math.cos(currentAngle);
            final y = radius * math.sin(currentAngle);

            return Transform.translate(
              offset: Offset(x, y),
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _glowAnimation.value * 0.7,
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }

  Color _getStatusColor() {
    switch (widget.chapter.status) {
      case ChapterStatus.completed:
        return AppColors.completed;
      case ChapterStatus.current:
        return AppColors.primary;
      case ChapterStatus.locked:
        return AppColors.locked;
    }
  }

  IconData _getStatusIcon() {
    switch (widget.chapter.status) {
      case ChapterStatus.completed:
        return Icons
            .library_books_rounded; // Stack of books for completed reading
      case ChapterStatus.current:
        return Icons
            .auto_stories; // Open book with flowing pages for current reading
      case ChapterStatus.locked:
        return Icons.import_contacts; // Closed book for locked chapters
    }
  }

  void _handleTap() {
    if (widget.chapter.status != ChapterStatus.locked) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });

      // Call the onTap callback (to be passed from parent)
      widget.onTap?.call();

      // 👉 Extra logic after tap (without changing UI)
      _onChapterTapAction();
    }
  }

  /// Handles custom actions when chapter is tapped
  void _onChapterTapAction() {
    switch (widget.chapter.status) {
      case ChapterStatus.completed:
        debugPrint(
            "✅ Chapter ${widget.chapter.chapterNumber} already completed!");
        break;
      case ChapterStatus.current:
        debugPrint("📖 Start reading Chapter ${widget.chapter.chapterNumber}");
        // Example: navigate to quiz or reading screen
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (_) => ChapterQuizScreen(chapter: widget.chapter),
        // ));
        break;
      case ChapterStatus.locked:
        debugPrint("🔒 Chapter locked");
        break;
    }
  }

}
