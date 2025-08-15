import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// COLORS PALETTE
import 'core/constants/app_colors.dart';
// BIBLE PATH FEATURE
import 'features/bible_path/data/repositories/chapter_repo_impl.dart';
import 'features/bible_path/domain/usecases/get_chapters_usecase.dart';
import 'features/bible_path/presentation/manager/chapter_cubit/chapter_cubit.dart';
import 'features/bible_path/presentation/pages/bible_path_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
// OTHER PAGES (create empty widgets for now)
import 'features/quiz/presentation/widgets/quizzes_page.dart';

void main() {
  runApp(const MyApp());
}

/// === Duolingo-style Bottom Nav with Ripple & Scale Animation === ///
class AnimatedBottomNavBar extends StatelessWidget {
  final int current;
  final Function(int) onTap;

  const AnimatedBottomNavBar({
    super.key,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: current,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      items: [
        _buildItem(Icons.home_outlined, Icons.home_rounded, 'Home', 0),
        _buildItem(Icons.quiz_outlined, Icons.quiz, 'Learn', 1),
        _buildItem(Icons.person_outline, Icons.person, 'Profile', 2),
        _buildItem(Icons.storefront_outlined, Icons.storefront, 'Shop', 3),
        _buildItem(Icons.emoji_events_outlined, Icons.emoji_events, 'Rank', 4),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(
    IconData icon,
    IconData active,
    String label,
    int index,
  ) {
    final bool isSelected = index == current;

    return BottomNavigationBarItem(
      label: label,
      icon: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: isSelected ? 0.0 : 1.0,
          end: isSelected ? 1.0 : 0.0,
        ),
        duration: const Duration(milliseconds: 400),
        builder: (_, double value, child) {
          final v = value.clamp(0.0, 1.0);
          return Stack(
            alignment: Alignment.center,
            children: [
              // Ripple circle background
              Container(
                width: 40 * v,
                height: 40 * v,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.15 * (1 - value)),
                ),
              ),
              // Icon with scale
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Padding(
                  padding: EdgeInsets.only(top: isSelected ? 0 : 6),
                  child: Icon(isSelected ? active : icon),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorSchemeSeed: AppColors.primary,
        useMaterial3: true,
      ),
      home: const RootNav(),
    );
  }
}

class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AnimatedBottomNavBar(
        current: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
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
