import 'dart:math' as math;

import 'package:flutter/material.dart';

class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double minSize;
  final double maxSize;

  const FloatingParticles({
    super.key,
    this.particleCount = 20,
    this.particleColor = const Color(0x33D4AF37),
    this.minSize = 2.0,
    this.maxSize = 8.0,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class ParticleData {
  double x;
  double y;
  final double size;
  final double speed;
  final double direction;
  final double opacity;

  ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.direction,
    required this.opacity,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<ParticleData> particles;
  final double animation;
  final Color particleColor;

  ParticlesPainter({
    required this.particles,
    required this.animation,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (var particle in particles) {
      // Update particle position
      particle.x += math.cos(particle.direction) * particle.speed * 0.01;
      particle.y += math.sin(particle.direction) * particle.speed * 0.01;

      // Wrap around screen
      if (particle.x > 1.0) particle.x = 0.0;
      if (particle.x < 0.0) particle.x = 1.0;
      if (particle.y > 1.0) particle.y = 0.0;
      if (particle.y < 0.0) particle.y = 1.0;

      // Draw particle with pulsing effect
      final pulseEffect = 0.8 + 0.2 * math.sin(animation * 2 * math.pi);
      final particleSize = particle.size * pulseEffect;

      paint.color = particleColor.withOpacity(particle.opacity * pulseEffect);

      // Draw particle with gradient effect
      final center = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      paint.shader = RadialGradient(
        colors: [
          particleColor.withOpacity(particle.opacity * pulseEffect),
          particleColor.withOpacity(0.1 * pulseEffect),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: particleSize));

      canvas.drawCircle(center, particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late List<ParticleData> particles;
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: ParticlesPainter(
                particles: particles,
                animation: _controller.value,
                particleColor: widget.particleColor,
              ),
            );
          },
        ),
      ),
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
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    particles = List.generate(widget.particleCount, (index) {
      return ParticleData(
        x: math.Random().nextDouble(),
        y: math.Random().nextDouble(),
        size: widget.minSize +
            math.Random().nextDouble() * (widget.maxSize - widget.minSize),
        speed: 0.1 + math.Random().nextDouble() * 0.3,
        direction: math.Random().nextDouble() * 2 * math.pi,
        opacity: 0.3 + math.Random().nextDouble() * 0.4,
      );
    });
  }
}
