import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytquran/provider/ScheduleProvider.dart';
import 'package:ytquran/provider/SettingsProvider.dart';

import 'NavigationScreen.dart';
import 'constant.dart';
import 'job/Algorithm.dart';

@pragma('vm:entry-point')
void arcReactor() async => await algorithm();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await ClearAllNotifications.clear();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // Provider<ScheduleController>(create: (context) => ScheduleController())
      ],
      child: const MyApp(),
    ),
  );
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 1),
    Constant.ARC_REACTOR_ID,
    arcReactor,
    wakeup: true,
    exact: true,
    allowWhileIdle: true,
    rescheduleOnReboot: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Peace Time',
      theme: Constant.lightMode,
      darkTheme: Constant.darkMode,
      themeMode: Provider.of<SettingsProvider>(context).settings.theme,
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
