import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _themeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _themeAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SlideTransition(
        position: _slideAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Settings content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Theme section
                      _buildThemeSection(),

                      const SizedBox(height: 32),

                      // App info section
                      _buildAppInfoSection(),

                      const SizedBox(height: 32),

                      // About section
                      _buildAboutSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _themeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Slide animation for screen entrance
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Theme selection animation
    _themeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _themeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _themeController,
      curve: Curves.easeOut,
    ));

    _slideController.forward();
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'حول التطبيق',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              fontFamily: 'Cairo',
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.auto_stories_outlined,
            title: 'الهدف',
            description: 'تسهيل دراسة وفهم الكتاب المقدس',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.school_outlined,
            title: 'المنهج',
            description: 'التعلم التفاعلي بنظام الدوولينجو',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.favorite_outlined,
            title: 'المصمم',
            description: 'تم تطويره بحب وعناية',
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // App icon and name
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_stories,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biblingo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'الإصدار 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                        fontFamily: 'Cairo',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // App description
          const Text(
            'تطبيق تعليمي تفاعلي لدراسة الكتاب المقدس بأسلوب ممتع وشيق مع نظام التقدم المرحلي والأسئلة التفاعلية',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
              fontFamily: 'Cairo',
              height: 1.6,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          Container(
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Title
          const Expanded(
            child: Text(
              'الإعدادات',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),

          // Settings icon
          Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  fontFamily: 'Cairo',
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontFamily: 'Cairo',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            Icon(
              Icons.palette_outlined,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'اختيار لون التطبيق',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                fontFamily: 'Cairo',
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),

        const SizedBox(height: 8),

        const Text(
          'اختر اللون المفضل لديك لتخصيص تجربة التطبيق',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textMuted,
            fontFamily: 'Cairo',
          ),
          textDirection: TextDirection.rtl,
        ),

        const SizedBox(height: 20),

        // Theme grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: AppTheme.values.map((theme) {
            final themeInfo = AppColors.themeInfo[theme]!;
            final isSelected = AppColors.currentTheme == theme;

            return AnimatedBuilder(
              animation: _themeAnimation,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () => _selectTheme(theme),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.getThemeColors(theme).primary,
                          AppColors.getThemeColors(theme).secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(
                              color: Colors.white,
                              width: 3,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.getThemeColors(theme)
                              .primary
                              .withOpacity(0.3),
                          blurRadius: isSelected ? 20 : 8,
                          offset: const Offset(0, 4),
                          spreadRadius: isSelected ? 2 : 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Theme icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              themeInfo.icon,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Theme info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                themeInfo.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                themeInfo.description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.8),
                                  fontFamily: 'Cairo',
                                ),
                                textDirection: TextDirection.rtl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Selection indicator
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _selectTheme(AppTheme theme) {
    _themeController.forward().then((_) {
      setState(() {
        AppColors.setTheme(theme);
      });
      widget.onThemeChanged();
      _themeController.reverse();
    });
  }
}
