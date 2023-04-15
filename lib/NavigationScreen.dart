import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/controller/SettingsController.dart';
import 'package:ytquran/screen/AppIntroductionScreen.dart';
import 'package:ytquran/screen/ErrorScreen.dart';
import 'package:ytquran/screen/HelpScreen.dart';
import 'package:ytquran/screen/HomeScreen.dart';
import 'package:ytquran/screen/SettingsScreen.dart';
import 'package:ytquran/screen/SplashScreen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool? isAppIntroduction;

  Future<void> initialize() async {
    await DBController.reset();
    bool dndPermission = await SettingsController.getPermissionStatus();

    if (dndPermission) {
      isAppIntroduction = await DBController.getIntroductionScreenStatus();
    } else {
      isAppIntroduction = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    initialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    // Color systemNavigationBarColor =
    //     Theme.of(context).brightness == Brightness.dark
    //         ? Theme.of(context).cardColor
    //         : Colors.white;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: Theme.of(context).bottomAppBarTheme.color,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
    if (isAppIntroduction == true) {
      return AppIntroductionScreen();
    } else if (isAppIntroduction == false) {
      return HomeScreen();
    }
    return SplashScreen();
  }
}
