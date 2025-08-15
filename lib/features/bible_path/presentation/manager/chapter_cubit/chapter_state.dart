part of 'chapter_cubit.dart';

abstract class ChapterState {}

class ChapterInitial extends ChapterState {}

class ChapterLoading extends ChapterState {}

class ChapterLoaded extends ChapterState {
  final List<ChapterEntity> chapters;
  ChapterLoaded(this.chapters);
}

class ChapterError extends ChapterState {
  final String message;
  ChapterError(this.message);
}
