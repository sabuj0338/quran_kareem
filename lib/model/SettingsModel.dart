import 'package:flutter/material.dart';

class Settings {
  // final bool isForgroundServiceOn;
  // final bool isTaskOn;
  bool isDoNotDisturbPermissionStatus = false;
  bool introductionScreenStatus = false;
  bool defaultQuickSilentMode = false;
  bool isBatteryOptimizationDisabled = false;
  // bool darkMode = false;
  ThemeMode theme = ThemeMode.system;

  Settings({
    required this.isDoNotDisturbPermissionStatus,
    required this.introductionScreenStatus,
    required this.theme,
    required this.defaultQuickSilentMode,
    required this.isBatteryOptimizationDisabled,
  });
}
