import 'package:flutter/material.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  late bool _planeIndicatorsEnabled;

  ThemeMode get themeMode => _themeMode;

  bool get planeIndicatorsEnabled => _planeIndicatorsEnabled;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _planeIndicatorsEnabled =
        await _settingsService.arePlaneIndicatorsEnabled();
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> resetThemeMode() async {
    _themeMode = ThemeMode.system;
    notifyListeners();
    await _settingsService.updateThemeMode(ThemeMode.system);
  }

  // Expose a method to check if onboarding is complete
  Future<bool> loadOnboardingComplete() async {
    return await _settingsService.isOnboardingComplete();
  }

// Expose a method to update the onboarding status
  Future<void> completeOnboarding() async {
    await _settingsService.setOnboardingComplete(true);
    notifyListeners();
  }

// Expose a method to reset onboarding (for testing or other purposes)
  Future<void> resetOnboarding() async {
    await _settingsService.setOnboardingComplete(false);
    notifyListeners();
  }

  // Update the plane indicators setting
  Future<void> updatePlaneIndicatorsEnabled(bool isEnabled) async {
    if (isEnabled == _planeIndicatorsEnabled) return;
    _planeIndicatorsEnabled = isEnabled;
    notifyListeners();
    await _settingsService.setPlaneIndicatorsEnabled(isEnabled);
  }
}
