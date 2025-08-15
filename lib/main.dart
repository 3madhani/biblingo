import 'package:flutter/material.dart';

// COLORS PALETTE
import 'core/constants/app_colors.dart';
import 'features/home/presentation/pages/root_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorSchemeSeed: AppColors.primary,
        useMaterial3: true,
      ),
      home: const RootNav(),
    );
  }
}
