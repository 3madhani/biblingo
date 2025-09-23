// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/services.dart';

// // Sound effect types for better organization
// enum SoundEffect {
//   correctAnswer,
//   incorrectAnswer,
//   buttonTap,
//   chapterComplete,
//   levelUp,
//   achievementUnlocked,
//   passagePronunciation,
//   wordPronunciation,
// }

// class SoundService {
//   static SoundService? _instance;
//   static SoundService get instance => _instance ??= SoundService._();
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   bool _soundEnabled = true;
//   SoundService._();

//   bool get soundEnabled => _soundEnabled;

//   // Cleanup
//   void dispose() {
//     _audioPlayer.dispose();
//   }

//   Future<void> playAchievementUnlocked() async {
//     if (!_soundEnabled) return;

//     try {
//       await HapticFeedback.heavyImpact();
//       // Play a series of clicks for celebration
//       for (int i = 0; i < 3; i++) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         await HapticFeedback.lightImpact();
//       }
//     } catch (e) {
//       print('Error playing achievement sound: $e');
//     }
//   }

//   // Background music (optional)
//   Future<void> playBackgroundMusic() async {
//     if (!_soundEnabled) return;

//     try {
//       // await _audioPlayer.play(AssetSource('music/background.mp3'));
//       // await _audioPlayer.setVolume(0.3);
//       // await _audioPlayer.setReleaseMode(ReleaseMode.loop);
//     } catch (e) {
//       print('Error playing background music: $e');
//     }
//   }

//   Future<void> playButtonTap() async {
//     if (!_soundEnabled) return;

//     try {
//       await HapticFeedback.selectionClick();
//     } catch (e) {
//       print('Error playing button tap sound: $e');
//     }
//   }

//   Future<void> playChapterComplete() async {
//     if (!_soundEnabled) return;

//     try {
//       await HapticFeedback.mediumImpact();
//       // await _audioPlayer.play(AssetSource('sounds/achievement.mp3'));
//     } catch (e) {
//       print('Error playing chapter complete sound: $e');
//     }
//   }

//   // Play sound effects
//   Future<void> playCorrectAnswer() async {
//     if (!_soundEnabled) return;

//     try {
//       // Play system success sound
//       await SystemSound.play(SystemSoundType.click);

//       // You can replace this with custom audio files
//       // await _audioPlayer.play(AssetSource('sounds/correct.mp3'));
//     } catch (e) {
//       // Handle audio playback errors gracefully
//       print('Error playing correct answer sound: $e');
//     }
//   }

//   Future<void> playIncorrectAnswer() async {
//     if (!_soundEnabled) return;

//     try {
//       // Play system error sound
//       await HapticFeedback.lightImpact();

//       // You can replace this with custom audio files
//       // await _audioPlayer.play(AssetSource('sounds/incorrect.mp3'));
//     } catch (e) {
//       print('Error playing incorrect answer sound: $e');
//     }
//   }

//   Future<void> playLevelUp() async {
//     if (!_soundEnabled) return;

//     try {
//       await HapticFeedback.heavyImpact();
//       // await _audioPlayer.play(AssetSource('sounds/level_up.mp3'));
//     } catch (e) {
//       print('Error playing level up sound: $e');
//     }
//   }

//   // Arabic text pronunciation (when audio files are available)
//   Future<void> playPassagePronunciation(String passage) async {
//     if (!_soundEnabled) return;

//     try {
//       // This would play the Arabic pronunciation of the passage
//       // await _audioPlayer.play(AssetSource('audio/passages/${passage.hashCode}.mp3'));

//       // For now, just provide haptic feedback
//       await HapticFeedback.lightImpact();
//     } catch (e) {
//       print('Error playing passage pronunciation: $e');
//     }
//   }

//   Future<void> playWordPronunciation(String word) async {
//     if (!_soundEnabled) return;

//     try {
//       // This would play the pronunciation of a specific Arabic word
//       // await _audioPlayer.play(AssetSource('audio/words/${word.hashCode}.mp3'));

//       await HapticFeedback.selectionClick();
//     } catch (e) {
//       print('Error playing word pronunciation: $e');
//     }
//   }

//   void setSoundEnabled(bool enabled) {
//     _soundEnabled = enabled;
//   }

//   Future<void> stopBackgroundMusic() async {
//     try {
//       await _audioPlayer.stop();
//     } catch (e) {
//       print('Error stopping background music: $e');
//     }
//   }

//   void toggleSound() {
//     _soundEnabled = !_soundEnabled;
//   }
// }

// // Sound settings that can be saved to SharedPreferences
// class SoundSettings {
//   bool soundEffectsEnabled;
//   bool pronunciationEnabled;
//   bool backgroundMusicEnabled;
//   double volume;

//   SoundSettings({
//     this.soundEffectsEnabled = true,
//     this.pronunciationEnabled = true,
//     this.backgroundMusicEnabled = false,
//     this.volume = 0.7,
//   });

//   factory SoundSettings.fromJson(Map<String, dynamic> json) => SoundSettings(
//         soundEffectsEnabled: json['soundEffectsEnabled'] ?? true,
//         pronunciationEnabled: json['pronunciationEnabled'] ?? true,
//         backgroundMusicEnabled: json['backgroundMusicEnabled'] ?? false,
//         volume: json['volume']?.toDouble() ?? 0.7,
//       );

//   Map<String, dynamic> toJson() => {
//         'soundEffectsEnabled': soundEffectsEnabled,
//         'pronunciationEnabled': pronunciationEnabled,
//         'backgroundMusicEnabled': backgroundMusicEnabled,
//         'volume': volume,
//       };
// }
