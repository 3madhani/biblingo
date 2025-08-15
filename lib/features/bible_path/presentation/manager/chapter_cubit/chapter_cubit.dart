

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chapter_entity.dart';
import '../../../domain/usecases/get_chapters_usecase.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final GetChaptersUseCase usecase;
  ChapterCubit(this.usecase) : super(ChapterInitial());

  Future<void> load() async {
    emit(ChapterLoading());
    try {
      final data = await usecase();
      emit(ChapterLoaded(data));
    } catch (_) {
      emit(ChapterError("Cannot load chapters"));
    }
  }

  void completeCurrent() {
    final s = state;
    if (s is! ChapterLoaded) return;
    final list = List<ChapterEntity>.from(s.chapters);
    int currentIndex = list.indexWhere(
      (c) => c.status == ChapterStatus.current,
    );
    if (currentIndex == -1) return;

    list[currentIndex] = list[currentIndex].copyWith(
      status: ChapterStatus.completed,
      progress: 1.0,
    );

    int next = currentIndex + 1;
    if (next < list.length) {
      list[next] = list[next].copyWith(
        status: ChapterStatus.current,
        progress: 0.0,
      );
    }

    emit(ChapterLoaded(list));
  }
}
