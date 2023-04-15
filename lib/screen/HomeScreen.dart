import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytquran/screen/HelpScreen.dart';
import 'package:ytquran/screen/components/ScheduleList.dart';
import 'package:ytquran/screen/widgets/HelperWidgets.dart';
import 'package:ytquran/screen/widgets/FloatingActionBottomSheet.dart';
import 'package:ytquran/screen/widgets/MenuItemBottomSheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return FloatingActionBottomSheet();
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
      appBar: AppBar(
        title: Text("Masjid Mode".toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => HelpScreen()),
            ).then((response) => null),
          ),
          IconButton(
              onPressed: () async => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return MenuItemBottomSheet();
                    },
                  ),
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: ScheduleList(),
      ),
    );
  }
}
