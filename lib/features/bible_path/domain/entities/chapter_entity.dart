enum ChapterStatus { completed, current, locked }

class ChapterEntity {
  final String id;
  final String title;
  final ChapterStatus status;
  final double progress; // 0..1

  const ChapterEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.progress,
  });

  ChapterEntity copyWith({
    String? id,
    String? title,
    ChapterStatus? status,
    double? progress,
  }) {
    return ChapterEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }
}
