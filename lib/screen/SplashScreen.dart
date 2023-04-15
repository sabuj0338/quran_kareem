import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ytquran/NavigationScreen.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/screen/AppIntroductionScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // To make this screen full screen.
    // It will hide status bar and notch.
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
