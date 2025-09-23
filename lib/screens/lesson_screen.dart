import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class LessonScreen extends StatefulWidget {
  final int chapterNumber;
  final Question question;
  final Function(bool) onAnswer;
  final VoidCallback onBack;

  const LessonScreen({
    super.key,
    required this.chapterNumber,
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
  bool isCorrect = false;
  late AnimationController _timerController;
  late AnimationController _shakeController;
  int timeLeft = 60; // seconds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildPassageCard(),
                      const SizedBox(height: 24),
                      _buildQuestionCard(),
                      const SizedBox(height: 24),
                      _buildAnswerOptions(),
                      const SizedBox(height: 32),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _startTimer();
  }

  Widget _buildAnswerOption(int index) {
    final isSelected = selectedAnswer == index;
    final isCorrectAnswer = index == widget.question.correctAnswer;
    final showCorrectAnswer = showResult && isCorrectAnswer;
    final showWrongAnswer = showResult && isSelected && !isCorrectAnswer;

    Color backgroundColor = Colors.white;
    Color borderColor = AppColors.glassBorder;
    Color textColor = AppColors.textDark;

    if (showCorrectAnswer) {
      backgroundColor = AppColors.success.withOpacity(0.1);
      borderColor = AppColors.success;
      textColor = AppColors.success;
    } else if (showWrongAnswer) {
      backgroundColor = AppColors.error.withOpacity(0.1);
      borderColor = AppColors.error;
      textColor = AppColors.error;
    } else if (isSelected) {
      backgroundColor = AppColors.goldLight;
      borderColor = AppColors.goldPrimary;
      textColor = AppColors.goldPrimary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: showResult
            ? null
            : () {
                setState(() {
                  selectedAnswer = index;
                });
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            boxShadow: isSelected && !showResult
                ? [
                    BoxShadow(
                      color: AppColors.goldPrimary.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? textColor : Colors.transparent,
                  border: Border.all(
                    color: textColor,
                    width: 2,
                  ),
                ),
                child: showCorrectAnswer
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : showWrongAnswer
                        ? const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          )
                        : isSelected
                            ? Container(
                                margin: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.question.options[index],
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 600 + (index * 100)))
        .slideX(begin: 0.3, end: 0);
  }

  Widget _buildAnswerOptions() {
    return Column(
      children: List.generate(
        widget.question.options.length,
        (index) => _buildAnswerOption(index),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onBack,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.textDark,
                size: 18,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الإصحاح ${widget.chapterNumber}',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const Text(
                  'سفر التكوين',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Timer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: timeLeft > 10
                  ? AppColors.goldLight
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: timeLeft > 10
                    ? AppColors.goldSecondary
                    : Colors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: timeLeft > 10 ? AppColors.goldPrimary : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  '${timeLeft}s',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: timeLeft > 10 ? AppColors.goldPrimary : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'النص الكتابي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.question.passage,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              height: 1.8,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LinearProgressIndicator(
        value: 1 - _timerController.value,
        backgroundColor: AppColors.goldPrimary.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(
          timeLeft > 10 ? AppColors.goldPrimary : Colors.red,
        ),
        minHeight: 4,
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '؟',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.question.question,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSubmitButton() {
    final canSubmit = selectedAnswer != null && !showResult;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canSubmit ? _submitAnswer : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSubmit ? AppColors.goldPrimary : AppColors.locked,
          foregroundColor: Colors.white,
          elevation: canSubmit ? 8 : 0,
          shadowColor: AppColors.goldPrimary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: showResult
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isCorrect ? 'إجابة صحيحة!' : 'إجابة خاطئة',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : const Text(
                'تأكيد الإجابة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  void _startTimer() {
    _timerController.forward();

    // Update time left every second
    _timerController.addListener(() {
      final newTimeLeft = (60 * (1 - _timerController.value)).round();
      if (newTimeLeft != timeLeft) {
        setState(() {
          timeLeft = newTimeLeft;
        });
      }
    });
  }

  void _submitAnswer() {
    if (selectedAnswer == null) return;

    setState(() {
      isCorrect = selectedAnswer == widget.question.correctAnswer;
      showResult = true;
    });

    if (!isCorrect) {
      _shakeController.forward().then((_) => _shakeController.reset());
    }

    // Auto continue after showing result
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        widget.onAnswer(isCorrect);

        // // Then navigate
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => QuizResults(
              
        //     ),
        //   ),
        // );
      }
    });
  }
}
