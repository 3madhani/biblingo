import 'package:flutter/material.dart';

import 'chapter_node_widget.dart';

class BiblePathPageBody extends StatelessWidget {
  const BiblePathPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SnakeNodesPath(
      nodes: [
        PathNode(
          svgPath: 'assets/icons/star_begain.svg',
          status: NodeStatus.completed,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.current,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.locked,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.locked,
        ),
        PathNode(
          svgPath: 'assets/icons/next_mission.svg',
          status: NodeStatus.locked,
        ),
      ],
    );
  }
}
