import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final int progress;
  final int total;
  final Color? primaryColor;
  final Color? backgroundColor;
  final double height;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.total,
    this.primaryColor,
    this.backgroundColor,
    this.height = 12,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? (progress / total).clamp(0.0, 1.0) : 0.0;

    final effectivePrimaryColor = primaryColor ?? AppColors.goldPrimary;
    final effectiveBackgroundColor =
        backgroundColor ?? AppColors.goldPrimary.withOpacity(0.2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            children: [
              // Progress fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                width: constraints.maxWidth * percentage,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      effectivePrimaryColor,
                      effectivePrimaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: effectivePrimaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),

              // Shimmer effect
              if (percentage > 0)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 1500.ms,
                        color: Colors.white.withOpacity(0.3),
                      ),
                ),
            ],
          ),
        );
      },
    );
  }
}
