import 'dart:ui';

class Chapter {
  final int id;
  final int chapterNumber;
  final int bookId;
  final ChapterStatus status;

  Chapter({
    required this.id,
    required this.chapterNumber,
    required this.bookId,
    required this.status,
  });

  Chapter copyWith({
    int? id,
    int? chapterNumber,
    int? bookId,
    ChapterStatus? status,
  }) {
    return Chapter(
      id: id ?? this.id,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      bookId: bookId ?? this.bookId,
      status: status ?? this.status,
    );
  }
}

enum ChapterStatus { completed, current, locked }

class Book {
  final int id;
  final String name;
  final String colorKey;
  final List<Color> gradientColors;
  final int totalChapters;

  Book({
    required this.id,
    required this.name,
    required this.colorKey,
    required this.gradientColors,
    required this.totalChapters,
  });
}



class Question {
  final int id;
  final String passage;
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.id,
    required this.passage,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class StudyStats {
  final int totalChaptersStudied;
  final int totalTimeSpent; // in minutes
  final int currentStreak;
  final int totalQuizzes;
  final int averageScore;
  final int perfectScores;
  final int booksStarted;
  final int booksCompleted;

  StudyStats({
    required this.totalChaptersStudied,
    required this.totalTimeSpent,
    required this.currentStreak,
    required this.totalQuizzes,
    required this.averageScore,
    required this.perfectScores,
    required this.booksStarted,
    required this.booksCompleted,
  });
}

class BookProgress {
  final int id;
  final String name;
  final int totalChapters;
  final int completedChapters;
  final String color;
  final String gradientFrom;
  final String gradientTo;

  BookProgress({
    required this.id,
    required this.name,
    required this.totalChapters,
    required this.completedChapters,
    required this.color,
    required this.gradientFrom,
    required this.gradientTo,
  });

  double get progressPercentage => totalChapters > 0 ? completedChapters / totalChapters : 0.0;
}

class QuizResults {
  final int score;
  final int totalQuestions;
  final int timeSpent; // in seconds
  final List<int> correctAnswers;
  final List<int> wrongAnswers;

  QuizResults({
    required this.score,
    required this.totalQuestions,
    required this.timeSpent,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  double get scorePercentage => totalQuestions > 0 ? (score / totalQuestions) * 100 : 0.0;
  bool get isPerfectScore => score == totalQuestions;
}