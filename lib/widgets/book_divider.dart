import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class BookDivider extends StatefulWidget {
  final Book book;

  const BookDivider({
    super.key,
    required this.book,
  });

  @override
  State<BookDivider> createState() => _BookDividerState();
}

class _BookDividerState extends State<BookDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  Widget build(BuildContext context) {
    final bookColors = AppColors.bookColors[widget.book.id];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Stack(
        children: [
          // Main divider container with 3D effect
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  bookColors?.gradientStart ?? AppColors.primary,
                  bookColors?.gradientEnd ?? AppColors.secondary,
                ],
              ),
              boxShadow: [
                // Main shadow
                BoxShadow(
                  color: (bookColors?.primary ?? AppColors.primary)
                      .withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 2,
                ),
                // Inner highlight
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Shimmer effect
                AnimatedBuilder(
                  animation: _shimmerAnimation,
                  builder: (context, child) {
                    return Positioned(
                      left: _shimmerAnimation.value *
                          MediaQuery.of(context).size.width,
                      top: 0,
                      bottom: 0,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        transform: Matrix4.skewX(-0.3),
                      ),
                    );
                  },
                ),

                // Book name with Arabic styling
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Book icon
                        Icon(
                          Icons.library_books_rounded,
                          color: Colors.white,
                          size: 24,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Book name
                        Text(
                          widget.book.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Decorative elements
          Positioned(
            left: 20,
            top: 5,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 5,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          // Connection line to next section
          Positioned(
            bottom: -24,
            left: MediaQuery.of(context).size.width / 2 - 1,
            child: Container(
              width: 2,
              height: 24,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (bookColors?.primary ?? AppColors.primary).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    _shimmerController.repeat();
  }
}
