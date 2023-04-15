import 'package:intl/intl.dart';
import 'package:ytquran/constant.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/controller/ScheduleController.dart';
import 'package:ytquran/controller/SettingsController.dart';
import 'package:ytquran/helper/Helper.dart';
import 'package:ytquran/helper/MyNotification.dart';
import 'package:ytquran/job/MyAlarmManager.dart';
import 'package:ytquran/model/ScheduleModel.dart';
import 'package:real_volume/real_volume.dart';

Future<void> algorithm() async {
  print("===> 🤌 Thanos Snapped At [${DateTime.now()}]");

  List<Schedule>? schedules = await ScheduleController.getSchedules();
  // print("===> Schedules Count = ${schedules?.length}");

  // DateTime now = DateTime.now();
  // String formattedDate = DateFormat.jm().format(now);
  // await MyNotification().notificationDefaultSound(
  //     title: "Alarm service!", description: "[$formattedDate]");

  if (schedules == null) return;

  final index = schedules.indexWhere((schedule) =>
      (schedule.status == true &&
          Helper.isToday(schedule) == true &&
          (Helper.isNowBefore(schedule.start) == true ||
              Helper.isTimeBetween(schedule) == true)) ==
      true);

  // return if found that already once activated a schedule
  bool? __normalPeriod = await DBController.getNormalPeriod();
  // print("===> Index [$index], __normalPeriod [$__normalPeriod]");

  if (index < 0 && __normalPeriod == true) {
    await DBController.setNormalPeriod(false);
    __normalPeriod = false;
    await SettingsController.setNormalMode();
  }

  if (index < 0 && __normalPeriod == false) return;

  if (index < 0) return;

  if (Helper.isTimeBetween(schedules[index]) == true) {
    // print("===> Is between 😎 ");

    RingerMode currentSoundMode =
        await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerMode.NORMAL) {
      DateTime now = DateTime.now();
      // DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      // DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime =
          DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if (Helper.isEndTimeBeforeStartTime(
          schedules[index].start, schedules[index].end)) {
        endDateTime =
            DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      // print("Now = $now, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager().setOneShot(index, RingerMode.VIBRATE);
        await MyAlarmManager().setOneShotAt(
            endDateTime, index + Constant.NORMAL_MODE_ID, RingerMode.NORMAL);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager().setOneShot(index, RingerMode.SILENT);
        await MyAlarmManager().setOneShotAt(
            endDateTime, index + Constant.NORMAL_MODE_ID, RingerMode.NORMAL);
      }
    }
  } else if (Helper.isNowBefore(schedules[index].start) == true) {
    // print("===> Is now before 😎 ");

    RingerMode currentSoundMode =
        await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerMode.NORMAL) {
      DateTime now = DateTime.now();
      DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      DateTime startDateTime =
          DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime =
          DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if (Helper.isEndTimeBeforeStartTime(
          schedules[index].start, schedules[index].end)) {
        endDateTime =
            DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      // print("Start = $start, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager()
            .setOneShotAt(startDateTime, index, RingerMode.VIBRATE);
        await MyAlarmManager().setOneShotAt(
            endDateTime, index + Constant.NORMAL_MODE_ID, RingerMode.NORMAL);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager()
            .setOneShotAt(startDateTime, index, RingerMode.SILENT);
        await MyAlarmManager().setOneShotAt(
            endDateTime, index + Constant.NORMAL_MODE_ID, RingerMode.NORMAL);
      }
    }
  }
}
