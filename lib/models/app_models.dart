enum ChapterStatus { completed, current, locked }

class Chapter {
  final int id;
  final int chapterNumber;
  final int bookId;
  ChapterStatus status;

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

class Book {
  final int id;
  final String name;
  final String colorName;

  const Book({
    required this.id,
    required this.name,
    required this.colorName,
  });
}

class Question {
  final int id;
  final String passage;
  final String question;
  final List<String> options;
  final int correctAnswer;

  const Question({
    required this.id,
    required this.passage,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// Sample data
class AppData {
  static const List<Book> books = [
    Book(id: 1, name: 'سفر التكوين', colorName: 'emerald'),
    Book(id: 2, name: 'سفر الخروج', colorName: 'blue'),
    Book(id: 3, name: 'سفر اللاويين', colorName: 'purple'),
    Book(id: 4, name: 'سفر العدد', colorName: 'rose'),
  ];

  static List<Chapter> initialChapters = [
    Chapter(id: 1, chapterNumber: 1, bookId: 1, status: ChapterStatus.completed),
    Chapter(id: 2, chapterNumber: 2, bookId: 1, status: ChapterStatus.completed),
    Chapter(id: 3, chapterNumber: 3, bookId: 1, status: ChapterStatus.current),
    Chapter(id: 4, chapterNumber: 4, bookId: 1, status: ChapterStatus.locked),
    Chapter(id: 5, chapterNumber: 5, bookId: 1, status: ChapterStatus.locked),
    Chapter(id: 6, chapterNumber: 1, bookId: 2, status: ChapterStatus.locked),
    Chapter(id: 7, chapterNumber: 2, bookId: 2, status: ChapterStatus.locked),
    Chapter(id: 8, chapterNumber: 3, bookId: 2, status: ChapterStatus.locked),
    Chapter(id: 9, chapterNumber: 1, bookId: 3, status: ChapterStatus.locked),
    Chapter(id: 10, chapterNumber: 2, bookId: 3, status: ChapterStatus.locked),
  ];

  static const Question sampleQuestion = Question(
    id: 1,
    passage: "في البدء خلق الله السماوات والأرض. وكانت الأرض خربة وخالية، وعلى وجه الغمر ظلمة، وروح الله يرف على وجه المياه.",
    question: "ماذا خلق الله في البداية؟",
    options: [
      "الأرض فقط",
      "السماوات فقط", 
      "السماوات والأرض",
      "المياه والظلمة"
    ],
    correctAnswer: 2,
  );
}