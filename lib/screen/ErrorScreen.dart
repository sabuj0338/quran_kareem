import 'package:flutter/material.dart';
import 'package:ytquran/screen/widgets/HelperWidgets.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: emptyWidget(context),
      ),
    );
  }
}
