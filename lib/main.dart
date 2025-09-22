import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_colors.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const BiblingoApp());
}

class BiblingoApp extends StatelessWidget {
  const BiblingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Biblingo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: AppColors.ivory,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.normal,
            color: AppColors.textMuted,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.goldPrimary,
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: AppColors.goldPrimary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
