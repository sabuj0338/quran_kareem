import 'dart:async';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytquran/controller/DBController.dart';
import 'package:ytquran/controller/SettingsController.dart';
import 'package:ytquran/provider/ScheduleProvider.dart';
import 'package:ytquran/provider/SettingsProvider.dart';
import 'package:ytquran/screen/widgets/RestoreConfirmationBottomSheet.dart';
import 'package:ytquran/screen/widgets/ThemeModeBottomSheet.dart';
import 'package:ytquran/screen/widgets/custom_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _minute = 0;
  bool isLoading = false;

  Future<void> increment({int value = 5}) async {
    setState(() => isLoading = true);
    _minute += value;
    await DBController.setDefaultSilentMinute(_minute);
    setState(() => isLoading = false);
  }

  Future<void> decrement({int value = 5}) async {
    setState(() => isLoading = true);
    if (_minute - value >= 0) {
      _minute -= value;
    }
    await DBController.setDefaultSilentMinute(_minute);
    setState(() => isLoading = false);
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Restore Confirmation'),
          content: Text(
              "Are you sure want to restore your all data? All data of your app will be removed permanently."),
          actions: <Widget>[
            TextButton(
              child: Text(
                "NO",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "YES",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                Provider.of<ScheduleProvider>(context, listen: false)
                    .restoreDB();
                Provider.of<SettingsProvider>(context, listen: false).refresh();
                final snackBar = SnackBar(
                  content: Text('App restored successfylly'),
                  action: SnackBarAction(
                    label: 'Done',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () async {
      Provider.of<SettingsProvider>(context, listen: false).refresh();
      _minute = await DBController.getDefaultSilentMinute();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Settings'.toUpperCase()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings_sharp,
              // color: Colors.grey[700],
            ),
          ),
        ],
      ),
      body: _settingsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async =>
                  await Provider.of<SettingsProvider>(context, listen: false)
                      .refresh(),
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () => DisableBatteryOptimization
                          .showDisableBatteryOptimizationSettings(),
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          "Battery Optimization Disabled",
                          // style: TextStyle(color: Colors.grey[400]),
                        ),
                        subtitle: Text(
                          "Disable battery optimization. Otherwise auto silent will not work perfectly when phone battery is low.",
                          // style: TextStyle(color: Colors.grey[700]),
                        ),
                        trailing: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: CupertinoSwitch(
                            value: _settingsProvider
                                .settings.isBatteryOptimizationDisabled,
                            activeColor: Theme.of(context).primaryColor,
                            // trackColor: Colors.black,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          SettingsController.openDoNotDisturbSettings(),
                      child: ListTile(
                        title: Text(
                          "Do Not Disturb Mode",
                          // style: TextStyle(color: Colors.grey[400]),
                        ),
                        subtitle: Text(
                          "Allow for change sound mode",
                          // style: TextStyle(color: Colors.grey[700]),
                        ),
                        trailing: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: CupertinoSwitch(
                            value: _settingsProvider
                                .settings.isDoNotDisturbPermissionStatus,
                            activeColor: Theme.of(context).primaryColor,
                            // trackColor: Colors.black,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        "App Introduction",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        "Get tips & guidelines on startup",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                          value: _settingsProvider
                              .settings.introductionScreenStatus,
                          activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                          onChanged: (bool value) =>
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .toggleIntroductionScreenStatus(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        "Quick Silent",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        "Set vibrate mode default for quick silent",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                          value:
                              _settingsProvider.settings.defaultQuickSilentMode,
                          activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                          onChanged: (bool value) =>
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .toggleDefaultQuickSilentMode(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        "Application Theme Mode",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        _settingsProvider.settings.theme.name,
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () async =>
                          customBottomSheet(context, [ThemeModeBottomSheet()]),
                      // trailing: Transform.scale(
                      //   scale: 0.8,
                      //   alignment: Alignment.centerRight,
                      //   child: CupertinoSwitch(
                      //     value: _settingsProvider.settings.darkMode,
                      //     activeColor: Theme.of(context).primaryColor,
                      //     // trackColor: Colors.black,
                      //     onChanged: (bool value) =>
                      //         Provider.of<SettingsProvider>(context,
                      //                 listen: false)
                      //             .toggleDarkMode(),
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                        subtitle: Text(
                          "Set default minutes for quick silent",
                          // style: TextStyle(color: Colors.grey[400]),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Default Minutes'),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).primaryColor),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () => isLoading
                                          ? null
                                          : decrement(value: 5),
                                      child: Icon(Icons.remove,
                                          color: Colors.white)),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Text(
                                            _minute.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                  ),
                                  InkWell(
                                      onTap: () => isLoading
                                          ? null
                                          : increment(value: 5),
                                      child:
                                          Icon(Icons.add, color: Colors.white)),
                                ],
                              ),
                            ),
                            // IconButton(onPressed: () {}, icon: Icon(Icons.done))
                          ],
                        )),
                  ),
                  const SizedBox(height: 1),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        "Reset",
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        "Remove schedules and reset settings ⚠",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () async {
                        showModalBottomSheet(
                          // shape: const RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(20),
                          //     topRight: Radius.circular(20),
                          //   ),
                          // ),
                          // elevation: 20,
                          context: context,
                          builder: (BuildContext context) {
                            return RestoreConfirmationBottomSheet();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
