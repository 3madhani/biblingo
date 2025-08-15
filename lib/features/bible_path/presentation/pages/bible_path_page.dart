import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../manager/chapter_cubit/chapter_cubit.dart';
import '../widgets/chapter_node_widget.dart';
import '../widgets/snake_painter.dart';

class BiblePathPage extends StatefulWidget {
  const BiblePathPage({super.key});

  @override
  State<BiblePathPage> createState() => _BiblePathPageState();
}

class _BiblePathPageState extends State<BiblePathPage> {
  final ScrollController _scroll = ScrollController();
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Bible Path"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (state is ChapterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChapterLoaded) {
            final list = state.chapters;
            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: SnakePainter(
                      nodeCount: list.length,
                      scrollOffset: offset,
                      nodeSpacing: 150,
                      amplitude: 40,
                      xSpread: 80,
                      color: AppColors.accentDark,
                      strokeWidth: 4,
                    ),
                  ),
                ),
                ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.only(top: 60, bottom: 100),
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    bool isLeft = i % 2 == 0;
                    return Align(
                      alignment: isLeft
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          isLeft ? 20 : 0,
                          50,
                          isLeft ? 0 : 20,
                          0,
                        ),
                        child: ChapterNodeWidget(
                          entity: list[i],
                          onCompleted: () =>
                              context.read<ChapterCubit>().completeCurrent(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      setState(() => offset = _scroll.offset);
    });
    context.read<ChapterCubit>().load();
  }
}
