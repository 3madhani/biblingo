import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bible_path/data/repositories/chapter_repo_impl.dart';
import '../../../bible_path/domain/usecases/get_chapters_usecase.dart';
import '../../../bible_path/presentation/manager/chapter_cubit/chapter_cubit.dart';
import '../../../bible_path/presentation/pages/bible_path_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../quiz/presentation/widgets/quizzes_page.dart';

class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  final int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
    );
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (_) =>
            ChapterCubit(GetChaptersUseCase(ChapterRepoImpl()))..load(),
        child: const BiblePathPage(),
      ),
      const QuizzesPage(),
      const ProfilePage(),
    ];
  }
}
