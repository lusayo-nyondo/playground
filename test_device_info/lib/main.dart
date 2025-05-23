import 'package:flutter/material.dart';

import 'device_info.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? deviceInfo;

  @override
  void initState() {
    super.initState();
    collectDeviceInfo()
        .then((value) => setState(() => deviceInfo = value.toJson().toString()))
        .onError((e, s) => setState(() => deviceInfo = e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Center(
        child: deviceInfo == null ? Text('loading...') : Text(deviceInfo!),
      ),
    );
  }
}
