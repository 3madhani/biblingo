import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';
import '../services/app_data.dart';
import '../widgets/progress_bar.dart';

class StudyProgressScreen extends StatelessWidget {
  final VoidCallback onBack;

  const StudyProgressScreen({
    super.key,
    required this.onBack,
  });

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildStatsOverview(),
                      const SizedBox(height: 24),
                      _buildProgressChart(),
                      const SizedBox(height: 24),
                      _buildBooksProgress(),
                      const SizedBox(height: 24),
                      _buildAchievements(),
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

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    final isCompleted = achievement['completed'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.goldPrimary.withOpacity(0.1)
            : AppColors.locked.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? AppColors.goldPrimary.withOpacity(0.3)
              : AppColors.locked.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.goldPrimary : AppColors.locked,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:
                        isCompleted ? AppColors.goldPrimary : AppColors.locked,
                  ),
                ),
                Text(
                  achievement['description'] as String,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.goldPrimary,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {
        'title': 'بداية الرحلة',
        'description': 'أكمل أول إصحاح',
        'icon': Icons.play_arrow_rounded,
        'completed': true
      },
      {
        'title': 'طالب مجتهد',
        'description': '7 أيام متتالية',
        'icon': Icons.local_fire_department_rounded,
        'completed': true
      },
      {
        'title': 'قارئ متميز',
        'description': '10 فصول مكتملة',
        'icon': Icons.star_rounded,
        'completed': true
      },
      {
        'title': 'المثابر',
        'description': '30 يوم متتالي',
        'icon': Icons.emoji_events_rounded,
        'completed': false
      },
      {
        'title': 'الماستر',
        'description': 'أكمل كتاب كامل',
        'icon': Icons.workspace_premium_rounded,
        'completed': false
      },
    ];

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
                  color: AppColors.goldPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.emoji_events_rounded,
                    color: AppColors.goldPrimary, size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'الإنجازات',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: achievements
                .map((achievement) => _buildAchievementItem(achievement))
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildBookProgressItem(BookProgress book) {
    final bookColors =
        AppColors.bookColors[book.id] ?? AppColors.bookColors[1]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bookColors['light'],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: bookColors['primary']!.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: bookColors['primary'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: bookColors['primary'],
                      ),
                    ),
                    Text(
                      '${book.completedChapters} من ${book.totalChapters} إصحاح',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(book.progressPercentage * 100).round()}%',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: bookColors['primary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ProgressBar(
            progress: book.completedChapters,
            total: book.totalChapters,
            primaryColor: bookColors['primary'],
            backgroundColor: bookColors['primary']!.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksProgress() {
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
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_stories_rounded,
                    color: AppColors.success, size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'تقدم الكتب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: AppData.bookProgress
                .map((book) => _buildBookProgressItem(book))
                .toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.glassBackground.withOpacity(.2),
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
            onTap: onBack,
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
          const Expanded(
            child: Text(
              'تقدم الدراسة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.3, end: 0);
  }

  Widget _buildProgressChart() {
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
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.show_chart_rounded,
                    color: Color(0xFF3B82F6), size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'التقدم الأسبوعي',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Simple progress chart visualization
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final heights = [40.0, 60.0, 35.0, 80.0, 65.0, 45.0, 70.0];
                final colors = [
                  AppColors.goldPrimary,
                  const Color(0xFF3B82F6),
                  AppColors.success,
                  Colors.orange,
                  const Color(0xFF8B5CF6),
                  const Color(0xFFE11D48),
                  AppColors.goldPrimary,
                ];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: heights[index],
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                        .animate(delay: Duration(milliseconds: 100 * index))
                        .slideY(
                            begin: 1,
                            end: 0,
                            duration: 600.ms,
                            curve: Curves.elasticOut),
                    const SizedBox(height: 8),
                    Text(
                      ['ج', 'ن', 'ث', 'ا', 'خ', 'س', 'ح'][index],
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final stats = AppData.studyStats;

    return Container(
      padding: const EdgeInsets.all(10),
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
                child: const Icon(Icons.insights_rounded,
                    color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              const Text(
                'نظرة عامة على الإحصائيات',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard(
                'الفصول المكتملة',
                '${stats.totalChaptersStudied}',
                Icons.check_circle_rounded,
                AppColors.success,
              ),
              _buildStatCard(
                'الوقت الإجمالي',
                '${stats.totalTimeSpent} دقيقة',
                Icons.timer_rounded,
                const Color(0xFF3B82F6),
              ),
              _buildStatCard(
                'الأيام المتتالية',
                '${stats.currentStreak}',
                Icons.local_fire_department_rounded,
                Colors.orange,
              ),
              _buildStatCard(
                'معدل النجاح',
                '${stats.averageScore}%',
                Icons.star_rounded,
                AppColors.goldPrimary,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }
}
