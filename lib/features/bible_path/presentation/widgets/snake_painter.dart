import 'dart:math' as math;
import 'package:flutter/material.dart';

class SnakePainter extends CustomPainter {
  final int nodeCount;
  final double nodeSpacing;
  final double scrollOffset;
  final double amplitude;
  final double xSpread;
  final Color color;
  final double strokeWidth;

  SnakePainter({
    required this.nodeCount,
    required this.nodeSpacing,
    required this.scrollOffset,
    required this.amplitude,
    required this.xSpread,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final path = Path();

    final x0 = size.width / 2;
    double y = 60;

    for (int i = 0; i < nodeCount; i++) {
      final wave = math.sin((scrollOffset / 60) + i) * amplitude;
      final dx = (i % 2 == 0) ? x0 - xSpread + wave : x0 + xSpread + wave;

      if (i == 0) path.moveTo(x0, y);
      path.lineTo(dx, y);
      y += nodeSpacing;
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) =>
      oldDelegate.scrollOffset != scrollOffset;
}
