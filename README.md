# Biblingo - Beautiful Bible Learning App 📖✨

A stunning Flutter application for learning the Bible with Duolingo-style progression, featuring beautiful 3D visual effects, liquid glass navigation, and Arabic text support.

## 🌟 Features

### ✨ **Beautiful UI/UX**

- **Liquid Glass Bottom Navigation** - Ultra-transparent floating navigation with advanced blur effects
- **3D Visual Effects** - Chapter nodes with floating particles, glow effects, and depth shadows
- **Golden Theme** - Warm gold color palette with gradient overlays
- **Arabic Text Support** - Proper RTL text rendering with Cairo font family
- **Smooth Animations** - Fluid transitions, bounce effects, and shimmer animations

### 📚 **Learning Experience**

- **Chapter Progression** - Visual learning path with status indicators (completed, current, locked)
- **Book Organization** - Beautiful book dividers with color-coded sections
- **Interactive Lessons** - Multiple choice questions with immediate feedback
- **Progress Tracking** - Animated progress bar showing learning completion

### 🎨 **Enhanced Visual Design**

- **Book Icons** - Perfect book icons for chapter nodes instead of speakers
- **3D Chapter Nodes** - Floating particles, rotation animations, and glow effects for current chapters
- **Magical Effects** - Shimmer animations, shine effects, and floating elements
- **Responsive Design** - Optimized for mobile devices with smooth scaling

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/yourusername/biblingo.git
cd biblingo
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Add Cairo font files:**
   - Download Cairo font family from Google Fonts
   - Place font files in `assets/fonts/` directory:
     - `Cairo-Regular.ttf`
     - `Cairo-Medium.ttf`
     - `Cairo-SemiBold.ttf`
     - `Cairo-Bold.ttf`

4. **Run the app:**

```bash
flutter run
```

## 📱 App Structure

```
lib/
├── main.dart                    # App entry point
├── constants/
│   └── app_colors.dart         # Color palette and theme constants
├── models/
│   └── app_models.dart         # Data models and sample data
├── screens/
│   ├── main_screen.dart        # Main learning path screen
│   └── lesson_screen.dart      # Individual lesson screen
└── widgets/
    ├── liquid_glass_bottom_nav.dart  # Transparent navigation bar
    ├── chapter_node.dart             # 3D chapter nodes with book icons
    ├── book_divider.dart             # Beautiful book section dividers
    ├── learning_path.dart            # Scrollable learning path
    └── progress_bar.dart             # Animated progress indicator
```

## 🎨 Key Design Features

### **Liquid Glass Navigation**

- Ultra-transparent design (8% opacity)
- Advanced backdrop blur effects
- Floating above content with soft shadows
- Subtle shine animations and particle effects
- Perfect Arabic text rendering

### **3D Chapter Nodes**

- **Book Icons**: Uses `Icons.menu_book` variants for different states
- **Status-based Design**:
  - 📖 **Completed**: Solid book icon with green glow
  - 📔 **Current**: Outlined book with golden glow and floating particles
  - 📓 **Locked**: Simple book outline in gray
- **Magical Effects**: Rotating particles, pulse animations, and depth shadows

### **Enhanced Book Dividers**

- Gradient backgrounds with book-specific colors
- Shimmer animations across the surface
- 3D depth effects with multiple shadow layers
- Book icons and proper Arabic typography

## 🌍 Arabic Text Support

The app fully supports Arabic text with:

- **RTL (Right-to-Left) text direction**
- **Cairo font family** for beautiful Arabic rendering
- **Proper text alignment** and spacing
- **Cultural-appropriate design** elements

## 🎯 Sample Data

The app includes sample Bible content:

- **Books**: Genesis (التكوين), Exodus (الخروج), Leviticus (اللاويين), Numbers (العدد)
- **Chapters**: Multiple chapters per book with progression system
- **Questions**: Arabic Bible passages with multiple-choice questions

## 🛠 Customization

### Adding New Books

1. Update `AppData.books` in `models/app_models.dart`
2. Add corresponding color scheme in `AppColors.bookColors`
3. Update sample chapters data

### Modifying Colors

Edit `constants/app_colors.dart` to customize:

- Gold theme colors
- Book-specific color schemes
- Status colors (completed, current, locked)

### Enhancing Animations

All animations are controlled by `AnimationController`s in individual widgets:

- Adjust durations in widget `initState()` methods
- Modify curves and animation properties
- Add new particle effects or transitions

## 📈 Performance Optimizations

- **Efficient Animations**: Using `AnimationBuilder` for smooth 60fps animations
- **Memory Management**: Proper disposal of animation controllers
- **Lazy Loading**: Optimized scrolling with efficient widget rebuilding
- **Responsive Design**: Adaptive layouts for different screen sizes

## 🎉 Visual Highlights

- ✨ **Ultra-transparent navigation** that floats like liquid glass
- 🌟 **3D book icons** with perfect visual metaphors for reading
- 🎨 **Magical particle effects** around current chapters
- 📚 **Beautiful book dividers** with shimmer animations
- 🌈 **Smooth gradients** and depth effects throughout
- 🔥 **Responsive animations** that feel natural and fluid

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google Fonts** for the beautiful Cairo font family
- **Flutter Team** for the amazing framework
- **Material Design** for design inspiration
- **Bible Gateway** for Biblical text resources

---

Made with ❤️ and Flutter for Bible learning and spiritual growth 🙏
