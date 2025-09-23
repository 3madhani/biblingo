import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';

class LiquidGlassBottomNav extends StatefulWidget {
  final String activeTab;
  final Function(String) onTabChange;

  const LiquidGlassBottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  State<LiquidGlassBottomNav> createState() => _LiquidGlassBottomNavState();
}

class _LiquidGlassBottomNavState extends State<LiquidGlassBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _glowController;
  late AnimationController _floatController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowController, _floatController]),
      builder: (context, child) {
        return Positioned(
          bottom: 25,
          left: 20,
          right: 20,
          child: Transform.translate(
            offset: Offset(0, _floatController.value * 2),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.goldLight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  // Main shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  // Golden glow
                  BoxShadow(
                    color: AppColors.goldPrimary
                        .withOpacity(0.2 + _glowController.value * 0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glass background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.25),
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),

                    // Backdrop blur effect simulation
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.goldLight.withOpacity(0.3),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),

                    // Navigation items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            'path',
                            Icons.route,
                            'المسار',
                            widget.activeTab == 'path',
                          ),
                          _buildNavItem(
                            'progress',
                            Icons.trending_up,
                            'التقدم',
                            widget.activeTab == 'progress',
                          ),
                          _buildNavItem(
                            'community',
                            Icons.groups,
                            'المجتمع',
                            widget.activeTab == 'community',
                          ),
                          _buildNavItem(
                            'settings',
                            Icons.settings,
                            'الإعدادات',
                            widget.activeTab == 'settings',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _glowController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  Widget _buildNavItem(String tab, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        _rippleController.forward().then((_) {
          _rippleController.reset();
        });
        widget.onTabChange(tab);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.goldPrimary.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: isActive
              ? Border.all(
                  color: AppColors.goldPrimary.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                // Icon with 3D effect
                Transform.translate(
                  offset: isActive ? const Offset(0, -2) : Offset.zero,
                  child: Icon(
                    icon,
                    color:
                        isActive ? AppColors.goldPrimary : AppColors.textMuted,
                    size: 26,
                  ),
                ),

                // Ripple effect
                if (_rippleController.isAnimating && isActive)
                  AnimatedBuilder(
                    animation: _rippleController,
                    builder: (context, child) {
                      return Container(
                        width: 24 + _rippleController.value * 20,
                        height: 24 + _rippleController.value * 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.goldPrimary.withOpacity(
                              1.0 - _rippleController.value,
                            ),
                            width: 2,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),

            const SizedBox(height: 2),

            // Label
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.goldPrimary : AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isActive ? 1 : 0)
        .scaleXY(
          begin: 1.0,
          end: 1.1,
          duration: 200.milliseconds,
          curve: Curves.easeInOut,
        )
        .then()
        .shimmer(
          duration: 1.seconds,
          color: AppColors.goldPrimary.withOpacity(0.3),
        );
  }
}
