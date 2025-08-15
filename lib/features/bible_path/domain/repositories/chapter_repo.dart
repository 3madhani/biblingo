import '../entities/chapter_entity.dart';

abstract class ChapterRepo {
  Future<List<ChapterEntity>> getChapters();
}
