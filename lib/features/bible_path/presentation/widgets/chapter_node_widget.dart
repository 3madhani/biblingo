import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'animated_start_indicator.dart';

enum NodeStatus { locked, current, completed }

class PathNode {
  final String svgPath;
  final NodeStatus status;

  PathNode({required this.svgPath, required this.status});
}

class SnakeNodesPath extends StatelessWidget {
  final List<PathNode> nodes;
  final double amplitude; // how wide snake moves left/right

  const SnakeNodesPath({super.key, required this.nodes, this.amplitude = 80});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final dx = math.sin(index * 0.8) * amplitude;
        return Transform.translate(
          offset: Offset(dx, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _NodeWidget(node: nodes[index]),
          ),
        );
      },
    );
  }
}

class _NodeWidget extends StatelessWidget {
  final PathNode node;

  const _NodeWidget({required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (node.status == NodeStatus.current) AnimatedStartIndicator(),
        SvgPicture.asset(node.svgPath, width: 80, height: 80),
      ],
    );
  }
}
