import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  // Key to use for storing and retrieving themeMode
  final String themeKey = 'theme_mode';

  // Key for storing the onboarding status
  final String onboardingCompleteKey = 'onboarding_complete';

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to load themeMode from SharedPreferences
    final storedThemeMode = prefs.getString(themeKey);

    if (storedThemeMode == null) return ThemeMode.system;

    // Convert the stored string theme mode back into a ThemeMode
    return ThemeMode.values.firstWhere((e) => e.toString() == storedThemeMode,
        orElse: () => ThemeMode.system);
  }

  /// Persists the user's preferred ThemeMode to SharedPreferences.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();

    // Store themeMode as a string in SharedPreferences
    await prefs.setString(themeKey, theme.toString());
  }

  // Method to check if onboarding is completed
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingCompleteKey) ?? false;
  }

// Method to update onboarding status
  Future<void> setOnboardingComplete(bool isComplete) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompleteKey, isComplete);
  }
}
