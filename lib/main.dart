import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'services/user_progress_service.dart';
import 'screens/community_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/main_screen.dart';
import 'screens/quiz_results_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/study_progress_screen.dart';
import 'services/app_data.dart';
import 'widgets/liquid_glass_bottom_nav.dart';

void main() {
  runApp(const BiblingoApp());
}

class BiblingoApp extends StatelessWidget {
  const BiblingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProgressService()),
      ],
      child: Consumer<UserProgressService>(
        builder: (context, progressService, child) => MaterialApp(
          title: 'بيبلينجو - تعلم الكتاب المقدس',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.themeColors[progressService.currentTheme]!,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Cairo',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              displayMedium: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              displaySmall: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),
          home: const BiblingoMainApp(),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

class BiblingoMainApp extends StatefulWidget {
  const BiblingoMainApp({super.key});

  @override
  State<BiblingoMainApp> createState() => _BiblingoMainAppState();
}

class _BiblingoMainAppState extends State<BiblingoMainApp> {
  String _currentScreen = 'main';
  String _activeTab = 'path';
  int? _selectedChapter;
  Map<String, dynamic> _quizResults = {
    'score': 0,
    'totalQuestions': 1,
    'timeSpent': 0,
    'correctAnswers': <int>[],
    'wrongAnswers': <int>[],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProgressService>(
        builder: (context, progressService, child) {
          return Stack(
            children: [
              // Main Content
              _buildCurrentScreen(progressService),

              // Bottom Navigation
              if (_shouldShowBottomNav()) _buildBottomNavigation(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return LiquidGlassBottomNav(
      activeTab: _activeTab,
      onTabChange: _handleTabChange,
    );
  }

  Widget _buildCurrentScreen(UserProgressService progressService) {
    switch (_currentScreen) {
      case 'main':
        return MainScreen(onChapterClick: _handleChapterClick);

      case 'lesson':
        if (_selectedChapter == null) return Container();
        final chapter = progressService.chapters.firstWhere(
          (ch) => ch.id == _selectedChapter,
        );
        return LessonScreen(
          chapterNumber: chapter.chapterNumber,
          question: AppData.sampleQuestion,
          onAnswer: _handleAnswerSubmit,
          onBack: _handleBack,
        );

      case 'settings':
        return SettingsScreen(onBack: _handleBackFromSettings);

      case 'results':
        if (_selectedChapter == null) return Container();
        final chapter = progressService.chapters.firstWhere(
          (ch) => ch.id == _selectedChapter,
        );
        final book = AppData.books.firstWhere(
          (book) => book.id == chapter.bookId,
        );
        return QuizResultsScreen(
          score: _quizResults['score'],
          totalQuestions: _quizResults['totalQuestions'],
          timeSpent: _quizResults['timeSpent'],
          chapterNumber: chapter.chapterNumber,
          bookName: book.name,
          correctAnswers: _quizResults['correctAnswers'],
          wrongAnswers: _quizResults['wrongAnswers'],
          onContinue: _handleResultsContinue,
          onHome: _handleResultsHome,
        );

      case 'progress':
        return StudyProgressScreen(onBack: _handleBackFromProgress);

      case 'community':
        return CommunityScreen(onBack: _handleBackFromCommunity);

      default:
        return MainScreen(onChapterClick: _handleChapterClick);
    }
  }

  void _handleAnswerSubmit(bool correct) {
    final progressService =
        Provider.of<UserProgressService>(context, listen: false);

    if (correct && _selectedChapter != null) {
      // Update chapter status and unlock next chapter
      progressService.completeChapter(_selectedChapter!);
    }

    // Set quiz results for the results screen
    setState(() {
      _quizResults = {
        'score': correct ? 1 : 0,
        'totalQuestions': 1,
        'timeSpent': 30 +
            (DateTime.now().millisecondsSinceEpoch %
                120), // Random time 30-150s
        'correctAnswers':
            correct ? [AppData.sampleQuestion.correctAnswer] : <int>[],
        'wrongAnswers': correct ? <int>[] : [0], // Mock wrong answer
      };
    });

    if (correct && _selectedChapter != null) {
      // Update chapter status and unlock next chapter
      progressService.completeChapter(_selectedChapter!);
    }

    // Show results after a delay
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _currentScreen = 'results';
        });
      }
    });
  }

  void _handleBack() {
    setState(() {
      _currentScreen = 'main';
      _selectedChapter = null;
    });
  }

  void _handleBackFromCommunity() {
    setState(() {
      _currentScreen = 'main';
      _activeTab = 'path';
    });
  }

  void _handleBackFromProgress() {
    setState(() {
      _currentScreen = 'main';
      _activeTab = 'path';
    });
  }

  void _handleBackFromSettings() {
    setState(() {
      _currentScreen = 'main';
      _activeTab = 'path';
    });
  }

  void _handleChapterClick(int chapterId) {
    final progressService =
        Provider.of<UserProgressService>(context, listen: false);
    if (progressService.canAccessChapter(chapterId)) {
      setState(() {
        _selectedChapter = chapterId;
        _currentScreen = 'lesson';
      });
    }
  }

  void _handleResultsContinue() {
    setState(() {
      _currentScreen = 'main';
      _selectedChapter = null;
    });
  }

  void _handleResultsHome() {
    setState(() {
      _currentScreen = 'main';
      _selectedChapter = null;
    });
  }

  void _handleTabChange(String tab) {
    setState(() {
      _activeTab = tab;
      if (tab == 'path') {
        _currentScreen = 'main';
      } else if (tab == 'settings') {
        _currentScreen = 'settings';
      } else if (tab == 'progress') {
        _currentScreen = 'progress';
      } else if (tab == 'community') {
        _currentScreen = 'community';
      }
    });
  }

  bool _shouldShowBottomNav() {
    return !['settings', 'results', 'progress', 'community', 'lesson']
        .contains(_currentScreen);
  }
}
