import '../entities/chapter_entity.dart';
import '../repositories/chapter_repo.dart';

class GetChaptersUseCase {
  final ChapterRepo repo;
  GetChaptersUseCase(this.repo);

  Future<List<ChapterEntity>> call() => repo.getChapters();
}
