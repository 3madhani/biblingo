import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../services/user_progress_service.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProgressService>(
      builder: (context, progressService, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildThemeSection(progressService),
                          const SizedBox(height: 24),
                          _buildAppearanceSection(),
                          const SizedBox(height: 24),
                          _buildNotificationSection(),
                          const SizedBox(height: 24),
                          _buildAccountSection(),
                          const SizedBox(height: 24),
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
      },
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      'حول التطبيق',
      Icons.info_rounded,
      Column(
        children: [
          _buildSettingItem(
            'الإصدار',
            '1.0.0',
            Icons.code_rounded,
            enabled: false,
          ),
          _buildSettingItem(
            'الدعم الفني',
            'المساعدة والاتصال',
            Icons.help_rounded,
          ),
          _buildSettingItem(
            'تقييم التطبيق',
            'شاركنا رأيك',
            Icons.star_rate_rounded,
          ),
          _buildSettingItem(
            'شروط الاستخدام',
            'الأحكام والشروط',
            Icons.description_rounded,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildAccountSection() {
    return _buildSection(
      'الحساب',
      Icons.person_rounded,
      Column(
        children: [
          _buildSettingItem(
            'الملف الشخصي',
            'تحرير المعلومات',
            Icons.edit_rounded,
          ),
          _buildSettingItem(
            'الخصوصية',
            'إعدادات الخصوصية',
            Icons.privacy_tip_rounded,
          ),
          _buildSettingItem(
            'الأمان',
            'كلمة المرور والحماية',
            Icons.security_rounded,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildAppearanceSection() {
    return _buildSection(
      'المظهر',
      Icons.brightness_6_rounded,
      Column(
        children: [
          _buildSettingItem(
            'الوضع الليلي',
            'قريباً',
            Icons.dark_mode_rounded,
            enabled: false,
          ),
          _buildSettingItem(
            'حجم الخط',
            'متوسط',
            Icons.text_fields_rounded,
          ),
          _buildSettingItem(
            'اللغة',
            'العربية',
            Icons.language_rounded,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glassBackground.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.textDark,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.3, end: 0);
  }

  Widget _buildNotificationSection() {
    return _buildSection(
      'الإشعارات',
      Icons.notifications_rounded,
      Column(
        children: [
          _buildToggleItem(
            'تذكيرات يومية',
            'تلقي تذكير للدراسة يومياً',
            Icons.notification_important_rounded,
            true,
          ),
          _buildToggleItem(
            'إشعارات الإنجاز',
            'إشعار عند إكمال الفصول',
            Icons.emoji_events_rounded,
            true,
          ),
          _buildToggleItem(
            'إشعارات المجتمع',
            'تحديثات من أصدقائك',
            Icons.people_rounded,
            false,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSection(String title, IconData icon, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon,
      {bool enabled = true}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        enabled: enabled,
        leading: Icon(
          icon,
          color: enabled ? AppColors.textDark : AppColors.textMuted,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: enabled ? AppColors.textDark : AppColors.textMuted,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: enabled
              ? AppColors.textMuted
              : AppColors.textMuted.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        onTap: enabled ? () {} : null,
      ),
    );
  }

  Widget _buildThemeSection(UserProgressService progressService) {
    final themes = [
      {
        'id': 'golden',
        'name': 'الذهبي',
        'color': AppColors.goldPrimary,
        'icon': Icons.star_rounded
      },
      {
        'id': 'ocean',
        'name': 'المحيط',
        'color': const Color(0xFF3B82F6),
        'icon': Icons.water_drop_rounded
      },
      {
        'id': 'forest',
        'name': 'الغابة',
        'color': const Color(0xFF10B981),
        'icon': Icons.eco_rounded
      },
      {
        'id': 'sunset',
        'name': 'الغروب',
        'color': const Color(0xFFEA580C),
        'icon': Icons.wb_sunny_rounded
      },
      {
        'id': 'royal',
        'name': 'الملكي',
        'color': const Color(0xFF8B5CF6),
        'icon': Icons.diamond_rounded
      },
      {
        'id': 'rose',
        'name': 'الوردي',
        'color': const Color(0xFFE11D48),
        'icon': Icons.favorite_rounded
      },
    ];

    return _buildSection(
      'السمات والألوان',
      Icons.palette_rounded,
      Column(
        children: [
          const Text(
            'اختر السمة المفضلة لديك',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = progressService.currentTheme == theme['id'];

              return GestureDetector(
                onTap: () => progressService.setTheme(theme['id'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (theme['color'] as Color).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? theme['color'] as Color
                          : AppColors.glassBorder,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: (theme['color'] as Color).withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme['color'] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          theme['icon'] as IconData,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        theme['name'] as String,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? theme['color'] as Color
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildToggleItem(
      String title, String subtitle, IconData icon, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textDark, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: (newValue) {},
          activeThumbColor: AppColors.goldPrimary,
          inactiveThumbColor: AppColors.textMuted,
          inactiveTrackColor: AppColors.textMuted.withOpacity(0.3),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      ),
    );
  }
}
