# Biblingo - تعلم الكتاب المقدس

A beautiful Duolingo-style Bible learning app built with Flutter, featuring Arabic text support, 3D visual effects, and a golden theme.

## Features

### 🎯 Core Learning Experience
- **Duolingo-style Learning Path**: Vertical progression with chapter nodes
- **Interactive Quizzes**: Multiple choice questions with immediate feedback
- **Progressive Unlocking**: Complete chapters to unlock new content
- **Arabic Text Support**: Full RTL support with beautiful Cairo font

### 🎨 Design & UI
- **Golden Theme**: Warm, elegant design with golden accents
- **3D Visual Effects**: Beautiful gradients and depth effects
- **Glass Morphism**: Modern glass-like components
- **Smooth Animations**: Engaging transitions and micro-interactions
- **Responsive Design**: Optimized for mobile devices

### 📚 Content Organization
- **Bible Books**: Organized by individual books (Genesis, Exodus, etc.)
- **Chapter Progression**: Each chapter is a separate learning node
- **Book Dividers**: Visual separators between different Bible books
- **Progress Tracking**: Visual progress indicators for each book

### 📊 Progress & Stats
- **Study Statistics**: Track completed chapters, time spent, streaks
- **Progress Visualization**: Charts and progress bars
- **Achievements System**: Unlock badges and rewards
- **Performance Analytics**: Detailed quiz results and analytics

### 👥 Community Features
- **Leaderboards**: Weekly and monthly rankings
- **Friends System**: Connect with other learners
- **Challenges**: Weekly and monthly learning challenges
- **Social Progress**: See friends' learning progress

### ⚙️ Customization
- **Multiple Themes**: Golden, Ocean, Forest, Sunset, Royal, Rose
- **Settings Panel**: Comprehensive app configuration
- **Notifications**: Study reminders and achievement alerts
- **Profile Management**: User profile and preferences

## Technical Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Animations**: flutter_animate
- **Fonts**: Google Fonts (Cairo)
- **Icons**: Material Icons with custom 3D designs

## Project Structure

```
lib/
├── constants/          # App-wide constants and colors
│   └── app_colors.dart
├── models/            # Data models
│   └── app_models.dart
├── screens/           # Main app screens
│   ├── main_screen.dart
│   ├── lesson_screen.dart
│   ├── quiz_results_screen.dart
│   ├── settings_screen.dart
│   ├── study_progress_screen.dart
│   └── community_screen.dart
├── services/          # Business logic and data
│   ├── app_data.dart
│   └── user_progress_service.dart
├── widgets/           # Reusable components
│   ├── chapter_node.dart
│   ├── book_divider.dart
│   ├── learning_path.dart
│   ├── liquid_glass_bottom_nav.dart
│   └── progress_bar.dart
└── main.dart          # App entry point
```

## Getting Started

### Prerequisites
- Flutter 3.0.0 or higher
- Dart 3.0.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add Cairo fonts**
   - Download Cairo font from [Google Fonts](https://fonts.google.com/specimen/Cairo)
   - Place font files in `assets/fonts/` directory:
     - Cairo-Regular.ttf
     - Cairo-Medium.ttf
     - Cairo-SemiBold.ttf
     - Cairo-Bold.ttf

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Features in Detail

### Learning Path System
The app uses a vertical learning path similar to Duolingo, where each chapter is represented as a node. Users progress through chapters in order, unlocking new content as they complete previous chapters.

### Quiz System
Each lesson contains:
- Bible passage in Arabic
- Multiple choice question
- Immediate feedback
- Progress tracking
- Time tracking

### Progress Tracking
- Local storage using SharedPreferences
- Chapter completion status
- XP points and streaks
- Book-by-book progress
- Time spent studying

### Theme System
The app supports multiple themes:
- **Golden** (default): Warm golden tones
- **Ocean**: Blue ocean-inspired colors
- **Forest**: Green nature theme
- **Sunset**: Orange sunset colors
- **Royal**: Purple royal theme
- **Rose**: Pink rose theme

## Customization

### Adding New Themes
1. Add colors to `AppColors.bookColors` in `constants/app_colors.dart`
2. Add theme option in `SettingsScreen`
3. Update theme switching logic in `UserProgressService`

### Adding New Content
1. Update `AppData.books` with new Bible books
2. Add corresponding chapters to `AppData.initialChapters`
3. Create questions for new chapters

### Modifying UI
- All UI constants are in `constants/app_colors.dart`
- Individual components are in `widgets/` directory
- Screens are in `screens/` directory

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by Duolingo's learning approach
- Cairo font by Google Fonts
- Flutter team for the amazing framework
- Material Design for UI components

---

Built with ❤️ using Flutter