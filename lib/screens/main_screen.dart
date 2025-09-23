import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../services/user_progress_service.dart';
import '../widgets/floating_particles.dart';
import '../widgets/learning_path.dart';
import '../widgets/progress_bar.dart';

class MainScreen extends StatefulWidget {
  final Function(int) onChapterClick;

  const MainScreen({
    super.key,
    required this.onChapterClick,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _backgroundController;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProgressService>(
      builder: (context, progressService, child) {
        final completedChapters = progressService.completedChapters;
        final totalChapters = progressService.chapters.length;

        return Scaffold(
          body: Stack(
            children: [
              // Floating particles background
              const FloatingParticles(
                particleCount: 25,
                particleColor: Color(0x33D4AF37),
                minSize: 2.0,
                maxSize: 8.0,
              ),

              // Animated background decorations
              _buildBackgroundDecorations(),
              Column(
                children: [
                  _buildHeader(context, progressService, completedChapters),

                  // Progress Section
                  _buildProgressSection(
                      context, completedChapters, totalChapters),

                  // Learning Path
                  Expanded(
                    child: LearningPath(
                      chapters: progressService.chapters,
                      onChapterClick: widget.onChapterClick,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _headerController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _headerController.forward();
  }

  Widget _buildBackgroundDecorations() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating golden orbs
            ...List.generate(5, (index) {
              final angle =
                  (_backgroundController.value + index / 5) * 2 * math.pi;
              final radius = 50.0 + index * 30;
              final x = MediaQuery.of(context).size.width / 2 +
                  math.cos(angle) * radius;
              final y = 200 + math.sin(angle * 0.7) * 100;

              return Positioned(
                left: x,
                top: y,
                child: Container(
                  width: 20 + index * 5,
                  height: 20 + index * 5,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        AppColors.goldSecondary.withOpacity(0.3),
                        AppColors.goldPrimary.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),

            // Decorative geometric shapes
            Positioned(
              right: 30,
              top: 150,
              child: Transform.rotate(
                angle: _backgroundController.value * 2 * math.pi,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.goldLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 40,
              top: 300,
              child: Transform.rotate(
                angle: -_backgroundController.value * 1.5 * math.pi,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.goldPrimary.withOpacity(0.2),
                        AppColors.goldSecondary.withOpacity(0.3),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, UserProgressService progressService,
      int completedChapters) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // App Icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppColors.buttonShadow,
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ).animate().scale(
                      delay: 100.ms,
                      duration: 600.ms,
                      curve: Curves.elasticOut),

                  const SizedBox(width: 16),

                  // App Title
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biblingo',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          'تعلم الكتاب المقدس',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats
                  Row(
                    children: [
                      _buildStatBadge(
                        Icons.local_fire_department_rounded,
                        '${progressService.currentStreak}',
                        Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      _buildStatBadge(
                        Icons.star_rounded,
                        '${progressService.totalXP}',
                        AppColors.goldPrimary,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Greeting
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.goldLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.goldSecondary,
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.waving_hand_rounded,
                      color: AppColors.goldPrimary,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'مرحباً بك! استمر في رحلتك لتعلم الكتاب المقدس',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(
      BuildContext context, int completedChapters, int totalChapters) {
    final progressPercentage = totalChapters > 0
        ? (completedChapters / totalChapters * 100).round()
        : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.glassBackground.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 2,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'تقدمك اليومي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '$completedChapters من $totalChapters إصحاح',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ProgressBar(
            progress: completedChapters,
            total: totalChapters,
          ),

          const SizedBox(height: 20),

          // Progress Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProgressStat(
                '$completedChapters',
                'مكتمل',
                const Color(0xFF3B82F6),
              ),
              _buildProgressStat(
                '7',
                'أيام متتالية',
                Colors.orange,
              ),
              _buildProgressStat(
                '$progressPercentage%',
                'نسبة الإنجاز',
                AppColors.goldPrimary,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildProgressStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBadge(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
