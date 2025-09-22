import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class LessonScreen extends StatefulWidget {
  final Chapter chapter;
  final Question question;
  final Function(bool) onAnswer;
  final VoidCallback onBack;

  const LessonScreen({
    super.key,
    required this.chapter,
    required this.question,
    required this.onAnswer,
    required this.onBack,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  int? selectedAnswer;
  bool showResult = false;
  late AnimationController _slideInController;
  late AnimationController _bounceController;
  late AnimationController _resultController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _resultAnimation;

  @override
  Widget build(BuildContext context) {
    final bookColors = AppColors.bookColors[widget.chapter.bookId];

    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  bookColors?.light.withOpacity(0.1) ?? AppColors.goldLight,
                  AppColors.ivory,
                  AppColors.beigeLight,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header with back button
                _buildHeader(),

                // Lesson content
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Chapter info
                          _buildChapterInfo(),

                          const SizedBox(height: 24),

                          // Passage card
                          _buildPassageCard(),

                          const SizedBox(height: 32),

                          // Question
                          _buildQuestion(),

                          const SizedBox(height: 24),

                          // Answer options
                          ...widget.question.options.asMap().entries.map(
                                (entry) =>
                                    _buildAnswerOption(entry.key, entry.value),
                              ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Result overlay
          if (showResult)
            AnimatedBuilder(
              animation: _resultAnimation,
              builder: (context, child) {
                final isCorrect =
                    selectedAnswer == widget.question.correctAnswer;
                return Positioned.fill(
                  child: Container(
                    color: (isCorrect ? AppColors.completed : Colors.red)
                        .withOpacity(0.1 * _resultAnimation.value),
                    child: Center(
                      child: Transform.scale(
                        scale: _resultAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isCorrect
                                    ? Icons.celebration
                                    : Icons.sentiment_dissatisfied,
                                size: 64,
                                color: isCorrect
                                    ? AppColors.completed
                                    : Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                isCorrect ? 'ممتاز!' : 'حاول مرة أخرى',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect
                                      ? AppColors.completed
                                      : Colors.red,
                                  fontFamily: 'Cairo',
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isCorrect
                                    ? 'إجابة صحيحة! استمر في التعلم'
                                    : 'الإجابة الصحيحة: ${widget.question.options[widget.question.correctAnswer]}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textMuted,
                                  fontFamily: 'Cairo',
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _slideInController.dispose();
    _bounceController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Slide in animation
    _slideInController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideInController,
      curve: Curves.easeOutCubic,
    ));

    // Bounce animation for options
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
    ));

    // Result animation
    _resultController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _resultAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _resultController,
      curve: Curves.elasticOut,
    ));

    _slideInController.forward();
  }

  Widget _buildAnswerOption(int index, String option) {
    final optionIcon = _getOptionIcon(index);

    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        final isSelected = selectedAnswer == index;
        return Transform.scale(
          scale: isSelected ? _bounceAnimation.value : 1.0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleAnswerSelection(index),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _getOptionColor(index),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _getOptionBorderColor(index),
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color:
                                  _getOptionBorderColor(index).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      // Option letter
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getOptionBorderColor(index),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Option text
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                            fontFamily: 'Cairo',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),

                      // Result icon
                      if (optionIcon != null) ...[
                        const SizedBox(width: 12),
                        Icon(
                          optionIcon,
                          color: _getOptionBorderColor(index),
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChapterInfo() {
    final book = AppData.books.firstWhere((b) => b.id == widget.chapter.bookId);
    final bookColors = AppColors.bookColors[widget.chapter.bookId];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bookColors?.gradientStart ?? AppColors.goldPrimary,
            bookColors?.gradientEnd ?? AppColors.goldSecondary,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                (bookColors?.primary ?? AppColors.goldPrimary).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.library_books_rounded,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              book.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          Container(
            decoration: BoxDecoration(
              color: AppColors.goldLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: widget.onBack,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.goldPrimary,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Title
          Expanded(
            child: Text(
              'الإصحاح ${widget.chapter.chapterNumber}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),

          // Book icon
          Icon(
            Icons.menu_book_rounded,
            color: AppColors.goldPrimary,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildPassageCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_quote,
                color: AppColors.goldPrimary,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'النص الكتابي',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontFamily: 'Cairo',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.question.passage,
            style: const TextStyle(
              fontSize: 18,
              height: 1.8,
              color: AppColors.textDark,
              fontFamily: 'Cairo',
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Text(
      widget.question.question,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
        fontFamily: 'Cairo',
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
    );
  }

  Color _getOptionBorderColor(int index) {
    if (!showResult) {
      return selectedAnswer == index
          ? AppColors.goldPrimary
          : Colors.grey[300]!;
    }

    if (index == widget.question.correctAnswer) {
      return AppColors.completed;
    } else if (selectedAnswer == index &&
        index != widget.question.correctAnswer) {
      return Colors.red;
    }

    return Colors.grey[300]!;
  }

  Color _getOptionColor(int index) {
    if (!showResult) {
      return selectedAnswer == index
          ? AppColors.goldPrimary.withOpacity(0.1)
          : Colors.white;
    }

    if (index == widget.question.correctAnswer) {
      return AppColors.completed.withOpacity(0.1);
    } else if (selectedAnswer == index &&
        index != widget.question.correctAnswer) {
      return Colors.red.withOpacity(0.1);
    }

    return Colors.white;
  }

  IconData? _getOptionIcon(int index) {
    if (!showResult) return null;

    if (index == widget.question.correctAnswer) {
      return Icons.check_circle;
    } else if (selectedAnswer == index &&
        index != widget.question.correctAnswer) {
      return Icons.cancel;
    }

    return null;
  }

  void _handleAnswerSelection(int optionIndex) {
    if (showResult) return;

    setState(() {
      selectedAnswer = optionIndex;
    });

    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });

    // Show result after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        showResult = true;
      });

      _resultController.forward();

      final isCorrect = optionIndex == widget.question.correctAnswer;

      // Auto close after showing result
      Future.delayed(const Duration(milliseconds: 2000), () {
        widget.onAnswer(isCorrect);
      });
    });
  }
}
