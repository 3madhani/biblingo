import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_colors.dart';
import '../models/app_models.dart';

class BookDivider extends StatelessWidget {
  final Book book;
  final int completedChapters;
  final int totalChapters;

  const BookDivider({
    super.key,
    required this.book,
    required this.completedChapters,
    required this.totalChapters,
  });

  @override
  Widget build(BuildContext context) {
    final bookColors =
        AppColors.bookColors[book.id] ?? AppColors.bookColors[1]!;
    final progressPercentage =
        totalChapters > 0 ? completedChapters / totalChapters : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          // Decorative top border
          Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bookColors['primary']!,
                  bookColors['secondary']!,
                  bookColors['primary']!,
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ).animate().scaleX(
              begin: 0, end: 1, duration: 800.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 16),

          // Book title and info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bookColors['light']!,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: bookColors['primary']!.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: bookColors['primary']!.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Book icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            bookColors['primary']!,
                            bookColors['secondary']!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: bookColors['primary']!.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Book info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.name,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bookColors['primary'],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$completedChapters من $totalChapters إصحاح',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Progress circle
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progressPercentage,
                            backgroundColor:
                                bookColors['primary']!.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              bookColors['primary']!,
                            ),
                            strokeWidth: 4,
                          ),
                          Text(
                            '${(progressPercentage * 100).round()}%',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: bookColors['primary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Progress bar
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: bookColors['primary']!.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            bookColors['primary']!,
                            bookColors['secondary']!,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 16),

          // Decorative bottom border
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  bookColors['primary']!.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
