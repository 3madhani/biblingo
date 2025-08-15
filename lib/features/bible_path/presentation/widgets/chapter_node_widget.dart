import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/chapter_entity.dart';

class ChapterNodeWidget extends StatefulWidget {
  final ChapterEntity entity;
  final VoidCallback onCompleted;

  const ChapterNodeWidget({
    super.key,
    required this.entity,
    required this.onCompleted,
  });

  @override
  State<ChapterNodeWidget> createState() => _ChapterNodeWidgetState();
}

class _ChapterNodeWidgetState extends State<ChapterNodeWidget>
    with TickerProviderStateMixin {
  late AnimationController _bounce;
  late Animation<double> _scale;
  late AnimationController _shake;
  double shakeValue = 0;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.92,
      upperBound: 1.05,
    )..repeat(reverse: true);
    _scale = CurvedAnimation(parent: _bounce, curve: Curves.easeInOut);

    if (widget.entity.status != ChapterStatus.current) {
      _bounce.stop();
    }
    _shake =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 350),
          )
          ..addListener(() {
            setState(() {
              shakeValue = math.sin(_shake.value * math.pi * 6) * 6;
            });
          })
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) _shake.reset();
          });
  }

  @override
  void didUpdateWidget(covariant ChapterNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entity.status == ChapterStatus.current) {
      if (!_bounce.isAnimating) _bounce.repeat(reverse: true);
    } else {
      _bounce.stop();
    }
  }

  void _handleTap() {
    if (widget.entity.status == ChapterStatus.locked) {
      _shake.forward();
      return;
    }
    if (widget.entity.status == ChapterStatus.current &&
        widget.entity.progress >= 1.0) {
      widget.onCompleted();
    }
  }

  @override
  void dispose() {
    _bounce.dispose();
    _shake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color base;
    IconData icon;
    switch (widget.entity.status) {
      case ChapterStatus.completed:
        base = AppColors.completed;
        icon = Icons.check_circle;
        break;
      case ChapterStatus.current:
        base = AppColors.current;
        icon = Icons.play_circle_fill;
        break;
      case ChapterStatus.locked:
        base = AppColors.locked;
        icon = Icons.lock;
        break;
    }

    return GestureDetector(
      onTap: _handleTap,
      child: Transform.translate(
        offset: Offset(shakeValue, 0),
        child: ScaleTransition(
          scale: widget.entity.status == ChapterStatus.current
              ? _scale
              : const AlwaysStoppedAnimation(1.0),
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: base.withOpacity(.15),
              border: Border.all(color: base, width: 3),
              boxShadow: widget.entity.status == ChapterStatus.current
                  ? [
                      BoxShadow(
                        color: base.withOpacity(.5),
                        blurRadius: 25,
                        spreadRadius: 4,
                      ),
                    ]
                  : [],
            ),
            child: Stack(
              children: [
                // Progress ring background
                CustomPaint(
                  painter: _RingPainter(
                    progress: widget.entity.progress,
                    color: base,
                  ),
                  child: Center(child: Icon(icon, size: 45, color: base)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _RingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size s) {
    const stroke = 6.0;
    final r = (s.width - stroke) / 2;
    final center = Offset(s.width / 2, s.height / 2);
    final bg = Paint()
      ..color = color.withOpacity(.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, r, bg);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      -math.pi / 2,
      sweepAngle,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}
