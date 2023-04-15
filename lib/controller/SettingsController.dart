import 'dart:async';
import 'package:real_volume/real_volume.dart';

class SettingsController {
  static Future<RingerMode> getCurrentSoundMode() async {
    RingerMode? ringerMode = await RealVolume.getRingerMode();
    // print(ringerMode?.name ?? 'Unknown');
    // print(RingerMode.SILENT);
    switch (ringerMode) {
      case RingerMode.NORMAL:
        return RingerMode.NORMAL;
      case RingerMode.SILENT:
        return RingerMode.SILENT;
      case RingerMode.VIBRATE:
        return RingerMode.VIBRATE;
      default:
        return RingerMode.NORMAL;
    }
    // RingerModeStatus ringerStatus;
    // try {
    //   ringerStatus = await SoundMode.ringerModeStatus;
    //   if (Platform.isIOS) {
    //     //because i no push meesage form ios to flutter,so need read two times
    //     await Future.delayed(Duration(milliseconds: 1000), () async {
    //       ringerStatus = await SoundMode.ringerModeStatus;
    //     });
    //   }
    // } catch (err) {
    //   ringerStatus = RingerModeStatus.unknown;
    //   print('Failed to get device\'s ringer status.$err');
    // }
  }

  static Future<bool> getPermissionStatus() async {
    // bool? permissionStatus = false;
    try {
      // permissionStatus = await PermissionHandler.permissionsGranted;
      bool? isPermissionGranted = await RealVolume.isPermissionGranted();
      // print(permissionStatus);
      return isPermissionGranted == true ? true : false;
    } catch (err) {
      // print(err);
      return false;
    }
  }

  static Future<void> setSilentMode() async {
    await RealVolume.setRingerMode(RingerMode.SILENT, redirectIfNeeded: false);
    // try {
    //   await SoundMode.setSoundMode(RingerModeStatus.silent);
    // } on PlatformException {
    //   print('Do Not Disturb access permissions required!');
    // }
  }

  static Future<void> setNormalMode() async {
    await RealVolume.setRingerMode(RingerMode.NORMAL, redirectIfNeeded: false);
    // try {
    //   await SoundMode.setSoundMode(RingerModeStatus.normal);
    // } on PlatformException {
    //   print('Do Not Disturb access permissions required!');
    // }
  }

  static Future<void> setVibrateMode() async {
    await RealVolume.setRingerMode(RingerMode.VIBRATE, redirectIfNeeded: false);
    // try {
    //   await SoundMode.setSoundMode(RingerModeStatus.vibrate);
    // } on PlatformException {
    //   print('Do Not Disturb access permissions required!');
    // }
  }

  static Future<void> openDoNotDisturbSettings() async {
    // await PermissionHandler.openDoNotDisturbSetting();
    await RealVolume.openDoNotDisturbSettings();
  }
}
