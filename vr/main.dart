import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:superarui/models/Lungs3D.dart';
import 'package:superarui/screens/home_screen.dart';

String iosAssetPath = '';
String taskId = '';
String documentDirectoryPath = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  FlutterDownloader.registerCallback(downloadCallback);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: MyApp(),
    ),
  );
}
