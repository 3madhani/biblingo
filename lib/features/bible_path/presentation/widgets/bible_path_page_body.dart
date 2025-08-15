import 'package:flutter/material.dart';

import 'chapter_node_widget.dart';

class BiblePathPageBody extends StatelessWidget {
  const BiblePathPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SnakeNodesPath(
        nodes: [
          PathNode(
            svgPath: 'assets/icons/star.svg',
            status: NodeStatus.completed,
          ),
          PathNode(
            svgPath: 'assets/icons/book_available.svg',
            status: NodeStatus.current,
          ),
          PathNode(
            svgPath: 'assets/icons/book_available.svg',
            status: NodeStatus.current,
          ),
          PathNode(
            svgPath: 'assets/icons/book_available.svg',
            status: NodeStatus.current,
          ),
          PathNode(
            svgPath: 'assets/icons/book_locked.svg',
            status: NodeStatus.locked,
          ),
          PathNode(
            svgPath: 'assets/icons/book_locked.svg',
            status: NodeStatus.locked,
          ),
          PathNode(
            svgPath: 'assets/icons/book_locked.svg',
            status: NodeStatus.locked,
          ),
          PathNode(
            svgPath: 'assets/icons/book_locked.svg',
            status: NodeStatus.locked,
          ),
          PathNode(
            svgPath: 'assets/icons/book_locked.svg',
            status: NodeStatus.locked,
          ),
        ],
      ),
    );
  }
}
