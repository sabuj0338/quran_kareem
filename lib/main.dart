import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ytquran/constant.dart';
import 'home.dart';
import 'names.dart';
import 'tasbih.dart';
import 'index.dart';


import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clear_all_notifications/clear_all_notifications.dart';

import 'package:ytquran/NavigationScreen.dart';

import 'package:ytquran/job/Algorithm.dart';
import 'package:ytquran/provider/ScheduleProvider.dart';
import 'package:ytquran/provider/SettingsProvider.dart';
import 'package:provider/provider.dart';

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
      child: MyApp(),
    ),
  );
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 1),
    Constant.ARC_REACTOR_ID,
    arcReactor,
    wakeup: true,
    exact: true,
    allowWhileIdle: false,
    rescheduleOnReboot: true,
  );
}




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding
        .instance
        .addPostFrameCallback(

            (_) async{
      await readJson();
      await getSettings();
    }

    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Masjid Mode Grid Quran"),),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.mosque,size: 50,color: Colors.white,),
              Text("Prayer Times",style: TextStyle(color: Colors.white,fontSize: 24),)
            ],),
            ),
          ),
           InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Names()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.apps,size: 50,color: Colors.white,),
              Text("99 Names of Allah",style: TextStyle(color: Colors.white,fontSize: 18),)
            ],),
            ),
          ),
         InkWell(
             onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>IndexPage()));
            },
           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.menu_book,size: 50,color: Colors.white,),
              Text("Quran",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
         ),
          InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Tasbih()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.check_box,size: 50,color: Colors.white,),
              Text("Tasbih",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
          InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.explore,size: 50,color: Colors.white,),
              Text("Qibla",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),
      ),),
    );
  }
}