import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/model/ScheduleModel.dart';

class ScheduleController {
  static Future<List<Schedule>?> getSchedules() async {
    String? schedules = await DBController.getSchedules();
    if (schedules == null)
      return null;
    else {
      List<Schedule> results = Schedule.decode(schedules);
      return results;
    }
  }
}
