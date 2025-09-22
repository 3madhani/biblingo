import 'package:flutter/material.dart';

class AppColors {
  static AppTheme _currentTheme = AppTheme.golden;

  // Extra named constants (can be reused across themes)
  static const Color ivory = Color(0xFFFFFFF0);
  static const Color beige = Color(0xFFF5F5DC);
  static const Color lightBeige = Color(0xFFFAF3E0);

  // Text colors (consistent across themes)
  static const Color textDark = Color(0xFF3A3A3A);
  static const Color textMuted = Color(0xFF7A7A7A);

  // Status colors
  static const Color completed = Color(0xFF10B981);
  static const Color locked = Color(0xFFD1D5DB);

  // Glass effects
  static const Color glassWhite = Color(0x20FFFFFF);
  static const Color glassBorder = Color(0x15FFFFFF);

  static const Color beigeLight = lightBeige;
  static Color get background => getThemeColors(_currentTheme).background;
  static Color get backgroundDark =>
      getThemeColors(_currentTheme).backgroundDark;

  static Color get backgroundLight =>
      getThemeColors(_currentTheme).backgroundLight;

  // Book colors (adapt to current theme)
  static Map<int, BookColors> get bookColors => {
        1: const BookColors(
          // Genesis
          primary: Color(0xFF10B981),
          light: Color(0xFF34D399),
          gradientStart: Color(0xFF059669),
          gradientEnd: Color(0xFF10B981),
        ),
        2: const BookColors(
          // Exodus
          primary: Color(0xFF3B82F6),
          light: Color(0xFF60A5FA),
          gradientStart: Color(0xFF1D4ED8),
          gradientEnd: Color(0xFF3B82F6),
        ),
        3: const BookColors(
          // Leviticus
          primary: Color(0xFF8B5CF6),
          light: Color(0xFFA78BFA),
          gradientStart: Color(0xFF7C3AED),
          gradientEnd: Color(0xFF8B5CF6),
        ),
        4: const BookColors(
          // Numbers
          primary: Color(0xFFF43F5E),
          light: Color(0xFFFB7185),
          gradientStart: Color(0xFFE11D48),
          gradientEnd: Color(0xFFF43F5E),
        ),
      };
  static Color get current => primary;
  static AppTheme get currentTheme => _currentTheme;

  static Color get goldLight => getThemeColors(AppTheme.golden).light;

  // Legacy aliases to avoid errors in LessonScreen
  static Color get goldPrimary => getThemeColors(AppTheme.golden).primary;

  static Color get goldSecondary => getThemeColors(AppTheme.golden).secondary;
  static Color get light => getThemeColors(_currentTheme).light;
  static Color get primary => getThemeColors(_currentTheme).primary;
  static Color get secondary => getThemeColors(_currentTheme).secondary;

  // Theme info for settings
  static Map<AppTheme, ThemeInfo> get themeInfo => {
        AppTheme.golden: const ThemeInfo(
          name: 'ذهبي كلاسيكي',
          description: 'اللون الذهبي التقليدي الأنيق',
          icon: '✨',
        ),
        AppTheme.ocean: const ThemeInfo(
          name: 'أزرق المحيط',
          description: 'هدوء البحر الأزرق',
          icon: '🌊',
        ),
        AppTheme.forest: const ThemeInfo(
          name: 'أخضر الغابة',
          description: 'نضارة الطبيعة الخضراء',
          icon: '🌲',
        ),
        AppTheme.sunset: const ThemeInfo(
          name: 'برتقالي الغروب',
          description: 'دفء غروب الشمس',
          icon: '🌅',
        ),
        AppTheme.royal: const ThemeInfo(
          name: 'بنفسجي ملكي',
          description: 'فخامة اللون البنفسجي',
          icon: '👑',
        ),
        AppTheme.rose: const ThemeInfo(
          name: 'وردي رومانسي',
          description: 'جمال الورود الوردية',
          icon: '🌹',
        ),
      };

  // Theme configurations - Made public for settings access
  static ThemeColors getThemeColors(AppTheme theme) {
    switch (theme) {
      case AppTheme.golden:
        return const ThemeColors(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFF4E4BC),
          light: Color(0xFFFAF6EB),
          background: ivory, // use named constant
          backgroundLight: Color(0xFFF5F2E8),
          backgroundDark: Color(0xFFE8DCC0),
        );
      case AppTheme.ocean:
        return const ThemeColors(
          primary: Color(0xFF0EA5E9),
          secondary: Color(0xFFBAE6FD),
          light: Color(0xFFF0F9FF),
          background: Color(0xFFF8FAFC),
          backgroundLight: Color(0xFFF1F5F9),
          backgroundDark: Color(0xFFE2E8F0),
        );
      case AppTheme.forest:
        return const ThemeColors(
          primary: Color(0xFF059669),
          secondary: Color(0xFFA7F3D0),
          light: Color(0xFFECFDF5),
          background: Color(0xFFF0FDF4),
          backgroundLight: Color(0xFFDCFCE7),
          backgroundDark: Color(0xFFBBF7D0),
        );
      case AppTheme.sunset:
        return const ThemeColors(
          primary: Color(0xFFEA580C),
          secondary: Color(0xFFFED7AA),
          light: Color(0xFFFFF7ED),
          background: Color(0xFFFFFBEB),
          backgroundLight: Color(0xFFFEF3C7),
          backgroundDark: Color(0xFFFDE68A),
        );
      case AppTheme.royal:
        return const ThemeColors(
          primary: Color(0xFF7C3AED),
          secondary: Color(0xFFDDD6FE),
          light: Color(0xFFFAF5FF),
          background: Color(0xFFFDF4FF),
          backgroundLight: Color(0xFFF3E8FF),
          backgroundDark: Color(0xFFE9D5FF),
        );
      case AppTheme.rose:
        return const ThemeColors(
          primary: Color(0xFFE11D48),
          secondary: Color(0xFFFCE7F3),
          light: Color(0xFFFDF2F8),
          background: Color(0xFFFFF1F2),
          backgroundLight: Color(0xFFFFE4E6),
          backgroundDark: Color(0xFFFECDD3),
        );
    }
  }

  static void setTheme(AppTheme theme) {
    _currentTheme = theme;
  }
}

enum AppTheme { golden, ocean, forest, sunset, royal, rose }

class BookColors {
  final Color primary;
  final Color light;
  final Color gradientStart;
  final Color gradientEnd;

  const BookColors({
    required this.primary,
    required this.light,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color light;
  final Color background;
  final Color backgroundLight;
  final Color backgroundDark;

  const ThemeColors({
    required this.primary,
    required this.secondary,
    required this.light,
    required this.background,
    required this.backgroundLight,
    required this.backgroundDark,
  });
}

class ThemeInfo {
  final String name;
  final String description;
  final String icon;

  const ThemeInfo({
    required this.name,
    required this.description,
    required this.icon,
  });
}
