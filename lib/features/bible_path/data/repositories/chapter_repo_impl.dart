import '../../domain/entities/chapter_entity.dart';
import '../../domain/repositories/chapter_repo.dart';

class ChapterRepoImpl implements ChapterRepo {
  @override
  Future<List<ChapterEntity>> getChapters() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      ChapterEntity(
        id: 'gen1',
        title: 'Genesis 1',
        status: ChapterStatus.completed,
        progress: 1.0,
      ),
      ChapterEntity(
        id: 'gen2',
        title: 'Genesis 2',
        status: ChapterStatus.current,
        progress: 0.7,
      ),
      ChapterEntity(
        id: 'gen3',
        title: 'Genesis 3',
        status: ChapterStatus.locked,
        progress: 0.0,
      ),
    ];
  }
}
