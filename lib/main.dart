import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/bible_path/data/repositories/chapter_repo_impl.dart';
import 'features/bible_path/domain/usecases/get_chapters_usecase.dart';
import 'features/bible_path/presentation/manager/chapter_cubit/chapter_cubit.dart';
import 'features/bible_path/presentation/pages/bible_path_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holy Path',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: BlocProvider(
        create: (_) => ChapterCubit(GetChaptersUseCase(ChapterRepoImpl())),
        child: BiblePathPage(),
      ),
    );
  }
}
