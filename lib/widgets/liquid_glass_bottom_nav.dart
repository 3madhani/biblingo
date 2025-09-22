import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class LiquidGlassBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LiquidGlassBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<LiquidGlassBottomNavigation> createState() =>
      _LiquidGlassBottomNavigationState();
}

class _LiquidGlassBottomNavigationState
    extends State<LiquidGlassBottomNavigation> with TickerProviderStateMixin {
  late AnimationController _shineController;
  late AnimationController _pulseController;
  late Animation<double> _shineAnimation;
  late Animation<double> _pulseAnimation;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {
        'icon': Icons.auto_stories_outlined,
        'activeIcon': Icons.auto_stories,
        'label': 'المسار'
      },
      {
        'icon': Icons.quiz_outlined,
        'activeIcon': Icons.quiz,
        'label': 'الأسئلة'
      },
      {
        'icon': Icons.bookmark_border_rounded,
        'activeIcon': Icons.bookmark,
        'label': 'المفضلة'
      },
      {
        'icon': Icons.settings_outlined,
        'activeIcon': Icons.settings,
        'label': 'الإعدادات'
      },
    ];

    return Positioned(
      bottom: 24,
      left: 16,
      right: 16,
      child: SizedBox(
        height: 80,
        child: Stack(
          children: [
            // Floating shadow - Much softer
            Positioned(
              bottom: -6,
              left: 4,
              right: 4,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
            ),

            // Main ultra-transparent glass container
            GestureDetector(
              onTap: _startShineEffect,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.08),
                          Colors.white.withOpacity(0.05),
                          Colors.white.withOpacity(0.03),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Ultra-subtle shine effect overlay (fixed)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          child: AnimatedBuilder(
                            animation: _shineAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  _shineAnimation.value *
                                      MediaQuery.of(context).size.width,
                                  0,
                                ),
                                child: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withOpacity(0.1),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  transform: Matrix4.skewX(-0.2),
                                ),
                              );
                            },
                          ),
                        ),

                        // Navigation items
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(tabs.length, (index) {
                              final tab = tabs[index];
                              final isActive = widget.currentIndex == index;

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => widget.onTap(index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeOutCubic,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: isActive
                                          ? LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                AppColors.primary
                                                    .withOpacity(0.08),
                                                AppColors.secondary
                                                    .withOpacity(0.05),
                                              ],
                                            )
                                          : null,
                                      border: isActive
                                          ? Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(0.15),
                                              width: 0.5,
                                            )
                                          : null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Icon with glow
                                        Stack(
                                          children: [
                                            Positioned(
                                              left: 0.5,
                                              top: 0.5,
                                              child: Icon(
                                                isActive
                                                    ? tab['activeIcon']
                                                        as IconData
                                                    : tab['icon'] as IconData,
                                                size: 24,
                                                color: isActive
                                                    ? AppColors.primary
                                                        .withOpacity(0.15)
                                                    : Colors.grey
                                                        .withOpacity(0.1),
                                              ),
                                            ),
                                            AnimatedBuilder(
                                              animation: _pulseAnimation,
                                              builder: (context, child) {
                                                return AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  transform: Matrix4.identity()
                                                    ..scale(isActive
                                                        ? 1.0 +
                                                            (_pulseAnimation
                                                                        .value -
                                                                    1.0) *
                                                                0.05
                                                        : 1.0),
                                                  child: Icon(
                                                    isActive
                                                        ? tab['activeIcon']
                                                            as IconData
                                                        : tab['icon']
                                                            as IconData,
                                                    size: 24,
                                                    color: isActive
                                                        ? AppColors.primary
                                                        : Colors.grey[600],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        // Label
                                        AnimatedDefaultTextStyle(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: isActive
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            color: isActive
                                                ? AppColors.primary
                                                : Colors.grey[600],
                                            fontFamily: 'Cairo',
                                          ),
                                          child: Text(
                                            tab['label'] as String,
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        // Bottom highlight
                        Positioned(
                          bottom: 0,
                          left: 20,
                          right: 20,
                          child: Container(
                            height: 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Shine animation controller
    _shineController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _shineAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shineController, curve: Curves.easeInOut),
    );

    // Pulse animation controller for active state
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start pulse animation for active tab
    _pulseController.repeat(reverse: true);
  }

  void _startShineEffect() {
    _shineController.forward().then((_) {
      _shineController.reset();
    });
  }
}
