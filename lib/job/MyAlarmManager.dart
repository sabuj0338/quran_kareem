import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:intl/intl.dart';
import 'package:ytquran/constant.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/controller/SettingsController.dart';
import 'package:ytquran/helper/MyNotification.dart';
import 'package:real_volume/real_volume.dart';

class MyAlarmManager {
  Future<void> setOneShot(int id, RingerMode mode) async {
    switch (mode) {
      case RingerMode.NORMAL:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 1),
          id,
          setNormal,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      case RingerMode.SILENT:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 1),
          id,
          setSilent,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      case RingerMode.VIBRATE:
        await AndroidAlarmManager.oneShot(
          const Duration(seconds: 1),
          id,
          setVibrate,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      default:
        return;
    }
  }

  Future<void> setOneShotAt(DateTime dateTime, int id, RingerMode mode) async {
    switch (mode) {
      case RingerMode.NORMAL:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setNormal,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      case RingerMode.SILENT:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setSilent,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      case RingerMode.VIBRATE:
        await AndroidAlarmManager.oneShotAt(
          dateTime,
          id,
          setVibrate,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
          alarmClock: true,
          allowWhileIdle: true,
        );
        return;
      default:
        return;
    }
  }

  @pragma('vm:entry-point')
  static Future<void> setSilent(int id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.jm().format(now);
    // print("Silent OneShot fired at! = [$id]");
    await MyNotification().notificationDefaultSound(
        title: "Silent Mode Activated!",
        description: "Activated at = [$formattedDate]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setSilentMode();
    await AndroidAlarmManager.cancel(id);
  }

  @pragma('vm:entry-point')
  static Future<void> setVibrate(int id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.jm().format(now);
    await MyNotification().notificationDefaultSound(
        title: "Vibration Mode Activated!",
        description: "Activated at = [$formattedDate]");
    // print("Vibrate OneShot fired at! = [$id]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setVibrateMode();
    await AndroidAlarmManager.cancel(id);
  }

  @pragma('vm:entry-point')
  static Future<void> setNormal(int id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.jm().format(now);
    await MyNotification().notificationDefaultSound(
        title: "Normal Mode!",
        description: "Back to normal mode at = [$formattedDate]");
    // print("Normal OneShot fired at! = [$id]");
    // await MyNotification().notificationDefaultSound(title: "Silent Mode Activated!", description: "Activated at = [$formattedDate]");
    await DBController.setNormalPeriod(false);
    await SettingsController.setNormalMode();
    await AndroidAlarmManager.cancel(id + Constant.NORMAL_MODE_ID);
  }

  static Future<void> stopEventById(int id) async {
    await AndroidAlarmManager.cancel(id + Constant.NORMAL_MODE_ID);
    await AndroidAlarmManager.cancel(id);
  }
}
