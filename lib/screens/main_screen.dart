import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';
import '../widgets/learning_path.dart';
import '../widgets/liquid_glass_bottom_nav.dart';
import '../widgets/progress_bar.dart';
import 'lesson_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentBottomNavIndex = 0;
  List<Chapter> _chapters = List.from(AppData.initialChapters);
  late AnimationController _headerAnimationController;
  late Animation<double> _headerSlideAnimation;

  int get _completedChapters {
    return _chapters.where((ch) => ch.status == ChapterStatus.completed).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.backgroundLight,
                  AppColors.background,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Animated Header
                AnimatedBuilder(
                  animation: _headerSlideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _headerSlideAnimation.value),
                      child: _buildHeader(),
                    );
                  },
                ),

                // Progress Bar
                ProgressBar(
                  progress: _completedChapters,
                  total: _chapters.length,
                ),

                // Learning Path
                Expanded(
                  child: LearningPath(
                    chapters: _chapters,
                    books: AppData.books,
                    onChapterTap: _handleChapterTap,
                  ),
                ),
              ],
            ),
          ),

          // Ultra-transparent floating bottom navigation
          LiquidGlassBottomNavigation(
            currentIndex: _currentBottomNavIndex,
            onTap: _handleBottomNavTap,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerSlideAnimation = Tween<double>(
      begin: -100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _headerAnimationController.forward();
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
          // App logo with 3D effect
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Shine effect
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7],
                    ),
                  ),
                ),

                // Logo text
                Text(
                  'B',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // App title
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biblingo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  'تعلم الكتاب المقدس',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                    fontFamily: 'Cairo',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),

          // Settings button
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => _handleBottomNavTap(3),
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAnswerSubmit(int chapterId, bool correct) {
    if (correct) {
      setState(() {
        _chapters = _chapters.map((ch) {
          if (ch.id == chapterId && ch.status == ChapterStatus.current) {
            return ch.copyWith(status: ChapterStatus.completed);
          }
          if (ch.id == chapterId + 1 && ch.status == ChapterStatus.locked) {
            return ch.copyWith(status: ChapterStatus.current);
          }
          return ch;
        }).toList();
      });
    }
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    if (index == 3) {
      // Settings tab
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SettingsScreen(
            onThemeChanged: () {
              setState(() {}); // Refresh the UI when theme changes
            },
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  void _handleChapterTap(int chapterId) {
    final chapter = _chapters.firstWhere((ch) => ch.id == chapterId);
    if (chapter.status != ChapterStatus.locked) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LessonScreen(
            chapter: chapter,
            question: AppData.sampleQuestion,
            onAnswer: (correct) => _handleAnswerSubmit(chapterId, correct),
            onBack: () => Navigator.of(context).pop(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }
}
