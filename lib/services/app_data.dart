import '../constants/app_colors.dart';
import '../models/app_models.dart';

class AppData {
  // Bible Books Data
  static final List<Book> books = [
    Book(
      id: 1,
      name: 'سفر التكوين',
      colorKey: 'genesis',
      gradientColors: AppColors.bookGradients['genesis']!,
      totalChapters: 50,
    ),
    Book(
      id: 2,
      name: 'سفر الخروج',
      colorKey: 'exodus',
      gradientColors: AppColors.bookGradients['exodus']!,
      totalChapters: 40,
    ),
    Book(
      id: 3,
      name: 'سفر اللاويين',
      colorKey: 'leviticus',
      gradientColors: AppColors.bookGradients['leviticus']!,
      totalChapters: 27,
    ),
    Book(
      id: 4,
      name: 'سفر العدد',
      colorKey: 'numbers',
      gradientColors: AppColors.bookGradients['numbers']!,
      totalChapters: 36,
    ),
    Book(
      id: 5,
      name: 'سفر التثنية',
      colorKey: 'deuteronomy',
      gradientColors: AppColors.bookGradients['deuteronomy']!,
      totalChapters: 34,
    ),
    Book(
      id: 6,
      name: 'سفر يشوع',
      colorKey: 'joshua',
      gradientColors: AppColors.bookGradients['joshua']!,
      totalChapters: 24,
    ),
  ];

  // Map of Bible bookId -> number of chapters
  static const Map<int, int> bookChapterCounts = {
    1: 50, // Genesis
    2: 40, // Exodus
    3: 27, // Leviticus
    4: 36, // Numbers
    5: 34, // Deuteronomy
    // 👉 continue until 66 books
  };

  static final List<Chapter> initialChapters = generateInitialChapters();

  static final Question sampleQuestion = Question(
    id: 1,
    passage:
        "فِي الْبَدْءِ خَلَقَ اللهُ السَّمَاوَاتِ وَالأَرْضَ. وَكَانَتِ الأَرْضُ خَرِبَةً وَخَالِيَةً، وَعَلَى وَجْهِ الْغَمْرِ ظُلْمَةٌ، وَرُوحُ اللهِ يَرِفُّ عَلَى وَجْهِ الْمِيَاهِ. وَقَالَ اللهُ: لِيَكُنْ نُورٌ، فَكَانَ نُورٌ.",
    question: "مَاذَا خَلَقَ اللهُ فِي الْبَدَايَةِ؟",
    options: [
      "الأَرْضَ فَقَطْ",
      "السَّمَاوَاتِ فَقَطْ",
      "السَّمَاوَاتِ وَالأَرْضَ",
      "الْمِيَاهَ وَالظُّلْمَةَ"
    ],
    correctAnswer: 2,
  );
  
  // Sample study statistics
  static final StudyStats studyStats = StudyStats(
    totalChaptersStudied: 12,
    totalTimeSpent: 240, // minutes
    currentStreak: 7,
    totalQuizzes: 15,
    averageScore: 87,
    perfectScores: 5,
    booksStarted: 2,
    booksCompleted: 0,
  );

  // تقدم الكتب
  static final List<BookProgress> bookProgress = [
    BookProgress(
      id: 1,
      name: 'سفر التكوين',
      totalChapters: 50,
      completedChapters: 12,
      color: 'emerald',
      gradientFrom: 'from-emerald-500',
      gradientTo: 'to-teal-600',
    ),
    BookProgress(
      id: 2,
      name: 'سفر الخروج',
      totalChapters: 40,
      completedChapters: 6,
      color: 'blue',
      gradientFrom: 'from-blue-500',
      gradientTo: 'to-indigo-600',
    ),
    BookProgress(
      id: 3,
      name: 'سفر اللاويين',
      totalChapters: 27,
      completedChapters: 2,
      color: 'purple',
      gradientFrom: 'from-purple-500',
      gradientTo: 'to-violet-600',
    ),
    BookProgress(
      id: 4,
      name: 'سفر العدد',
      totalChapters: 36,
      completedChapters: 0,
      color: 'rose',
      gradientFrom: 'from-rose-500',
      gradientTo: 'to-pink-600',
    ),
    BookProgress(
      id: 5,
      name: 'سفر التثنية',
      totalChapters: 34,
      completedChapters: 0,
      color: 'orange',
      gradientFrom: 'from-orange-500',
      gradientTo: 'to-amber-600',
    ),
    BookProgress(
      id: 6,
      name: 'سفر يشوع',
      totalChapters: 24,
      completedChapters: 0,
      color: 'cyan',
      gradientFrom: 'from-cyan-500',
      gradientTo: 'to-teal-600',
    ),
  ];

  static List<Chapter> generateInitialChapters() {
    final List<Chapter> chapters = [];
    int idCounter = 1;

    bookChapterCounts.forEach((bookId, chapterCount) {
      for (int i = 1; i <= chapterCount; i++) {
        ChapterStatus status;

        if (bookId == 1 && i <= 2) {
          status = ChapterStatus.completed; // first 2 chapters completed
        } else if (bookId == 1 && i == 3) {
          status = ChapterStatus.current; // current chapter
        } else {
          status = ChapterStatus.locked; // everything else locked
        }

        chapters.add(Chapter(
          id: idCounter++,
          chapterNumber: i,
          bookId: bookId,
          status: status,
        ));
      }
    });

    return chapters;
  }
}
