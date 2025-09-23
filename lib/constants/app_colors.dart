import 'package:flutter/material.dart';

class AppColors {
  // Book Colors with enhanced gradients
  static const Map<String, List<Color>> bookGradients = {
    'genesis': [Color(0xFF10B981), Color(0xFF059669)], // Emerald
    'exodus': [Color(0xFF3B82F6), Color(0xFF1D4ED8)], // Blue
    'leviticus': [Color(0xFF8B5CF6), Color(0xFF7C3AED)], // Purple
    'numbers': [Color(0xFFF43F5E), Color(0xFFE11D48)], // Rose
    'deuteronomy': [Color(0xFFF97316), Color(0xFFEA580C)], // Orange
    'joshua': [Color(0xFF06B6D4), Color(0xFF0891B2)], // Cyan
  };

  // Theme Colors
  static const Map<String, Color> themeColors = {
    'golden': AppColors.goldPrimary,
    'ocean': Color(0xFF3B82F6),
    'forest': Color(0xFF10B981),
    'sunset': Color(0xFFEA580C),
    'royal': Color(0xFF8B5CF6),
    'violet': Color(0xFF7C3AED),
    'rose': Color(0xFFF43F5E),
    'orange': Color(0xFFF97316),
    'cyan': Color(0xFF06B6D4),
    'emerald': Color(0xFF059669),
    'red': Color(0xFFEF4444),
  };
  // Golden Theme Colors
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldSecondary = Color(0xFFF4E4BC);
  static const Color goldLight = Color(0xFFFAF6EB);
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beigeLight = Color(0xFFF5F2E8);
  static const Color beigeDark = Color(0xFFE8DCC0);

  // Text Colors
  static const Color textDark = Color(0xFF3A3A3A);
  static const Color textMuted = Color(0xFF7A7A7A);
  static const Color background = Color(0xFFFEFCF8);

  // Status Colors
  static const Color completed = Color(0xFF10B981);
  static const Color current = Color(0xFFFBBF24);
  static const Color locked = Color(0xFF9CA3AF);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);

  // Book Colors Map
  static const Map<int, Map<String, Color>> bookColors = {
    1: {
      // سفر التكوين
      'primary': Color(0xFF10B981),
      'secondary': Color(0xFF34D399),
      'light': Color(0xFFD1FAE5),
    },
    2: {
      // سفر الخروج
      'primary': Color(0xFF3B82F6),
      'secondary': Color(0xFF60A5FA),
      'light': Color(0xFFDBEAFE),
    },
    3: {
      // سفر اللاويين
      'primary': Color(0xFF8B5CF6),
      'secondary': Color(0xFFA78BFA),
      'light': Color(0xFFEDE9FE),
    },
    4: {
      // سفر العدد
      'primary': Color(0xFFEC4899),
      'secondary': Color(0xFFF472B6),
      'light': Color(0xFFFCE7F3),
    },
    5: {
      // سفر التثنية
      'primary': Color(0xFFF59E0B),
      'secondary': Color(0xFFFBBF24),
      'light': Color(0xFFFEF3C7),
    },
    6: {
      // سفر يشوع
      'primary': Color(0xFF06B6D4),
      'secondary': Color(0xFF22D3EE),
      'light': Color(0xFFCFFAFE),
    },
  };

  // Gradient Definitions
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0xFFF1F5F9),
      Color(0xFFDBEAFE),
      Color(0xFFE0E7FF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Glass Effect Colors
  static Color glassBackground = Colors.white.withOpacity(0.7);
  static Color glassBorder = Colors.white.withOpacity(0.2);

  // Shadow Colors
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: goldPrimary.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];
}
