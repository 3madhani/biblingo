import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class _NodeWidget extends StatefulWidget {
  final PathNode node;

  const _NodeWidget({required this.node});

  @override
  State<_NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<_NodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.node.status == NodeStatus.current)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: const Text(
              'ابدأ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        SvgPicture.asset(widget.node.svgPath, width: 80, height: 80),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _animation = Tween(
      begin: -5.0,
      end: 5.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }
}
