import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

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
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: List.generate(nodes.length, (i) {
          // create wave movement
          final dx = math.sin(i * 0.8) * amplitude;

          return Transform.translate(
            offset: Offset(dx, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _NodeWidget(node: nodes[i]),
            ),
          );
        }),
      ),
    );
  }
}

class _NodeWidget extends StatelessWidget {
  final PathNode node;

  const _NodeWidget({required this.node});

  @override
  Widget build(BuildContext context) {
    const double size = 80;

    Color border;
    List<Color> gradient;
    double opacity = 1.0;

    switch (node.status) {
      case NodeStatus.completed:
        border = AppColors.completed;
        gradient = [const Color(0xFFa0e37f), const Color(0xFF63c966)];
        break;
      case NodeStatus.current:
        border = AppColors.current;
        gradient = [const Color(0xFF89CFF0), const Color(0xFF0077c2)];
        break;
      case NodeStatus.locked:
        border = AppColors.locked;
        gradient = [const Color(0xFFE0E0E0), const Color(0xFFBDBDBD)];
        opacity = 0.4;
        break;
    }

    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradient,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 6),
              blurRadius: 12,
            ),
          ],
          border: Border.all(color: border, width: 3),
        ),
        child: Center(
          child: SvgPicture.asset(node.svgPath, width: 40, height: 40),
        ),
      ),
    );
  }
}
