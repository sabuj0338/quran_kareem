import 'dart:async';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytquran/controller/SettingsController.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/model/SettingsModel.dart';

class SettingsProvider with ChangeNotifier {
  bool isLoading = true;
  bool isPending = false;
  Settings settings = Settings(
    isDoNotDisturbPermissionStatus: false,
    introductionScreenStatus: false,
    defaultQuickSilentMode: false,
    isBatteryOptimizationDisabled: false,
    theme: ThemeMode.system,
  );

  SettingsProvider() {
    // code..
    initialize();
  }

  Future<void> initialize() async {
    settings.isDoNotDisturbPermissionStatus =
        await SettingsController.getPermissionStatus();
    settings.introductionScreenStatus =
        await DBController.getIntroductionScreenStatus();
    settings.defaultQuickSilentMode =
        await DBController.getDefaultQuickSilentMode();
    settings.theme = await DBController.getThemeMode();

    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }

    bool? isBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled;

    settings.isBatteryOptimizationDisabled =
        isBatteryOptimizationDisabled == true ? true : false;

    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    initialize();
  }

  Future<void> toggleThemeMode(ThemeMode value) async {
    await DBController.setThemeMode(value);
    settings.theme = await DBController.getThemeMode();
    notifyListeners();
  }

  Future<void> themeModeStatus() async {
    settings.theme = await DBController.getThemeMode();
    notifyListeners();
  }

  Future<void> isPendingValue(bool value) async {
    isPending = value;
    notifyListeners();
  }

  Future<void> toggleIntroductionScreenStatus() async {
    if (settings.introductionScreenStatus == null) {
      settings.introductionScreenStatus = false;
    }
    await DBController.toggleIntroductionScreenStatus(
        !settings.introductionScreenStatus);

    settings.introductionScreenStatus = !settings.introductionScreenStatus;
    notifyListeners();
  }

  Future<void> toggleDefaultQuickSilentMode() async {
    if (settings.defaultQuickSilentMode == null) {
      settings.defaultQuickSilentMode = false;
    }
    await DBController.toggleDefaultQuickSilentMode(
        !settings.defaultQuickSilentMode);

    settings.defaultQuickSilentMode = !settings.defaultQuickSilentMode;
    notifyListeners();
  }
}
