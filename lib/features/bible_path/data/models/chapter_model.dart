import '../../domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.id,
    required super.title,
    required super.status,
    required super.progress,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'],
      title: json['title'],
      status: ChapterStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      progress: (json['progress'] as num).toDouble(),
    );
  }
}
