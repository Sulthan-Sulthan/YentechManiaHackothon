
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:superarui/backendscreens/native_ar_viewer.dart';
import 'package:superarui/main.dart';


class Skeleton extends StatefulWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  /// For Android Platform .glb format and for IOS .USDZ
  final String modelURL = io.Platform.isAndroid
            ? "https://firebasestorage.googleapis.com/v0/b/super-ar-be6d5.appspot.com/o/skeleton%2Fskell.glb?alt=media&token=6f1790fb-4e59-4557-ac18-670839082dd5"

      : "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/Asgive similar file acces to the below firebase:::  tronaut.usdz?alt=media&token=833344f6-7f17-4f21-aa5c-6f9fc5313928";

  @override
  void initState() {
    super.initState();
    _downloadAssetsForIOS();
  }

  _downloadAssetsForIOS() async {
    await _prepareSaveDir(); 
    taskId = (await FlutterDownloader.enqueue(
        url: modelURL, savedDir: documentDirectoryPath))!;
    print('taskId = $taskId');
  }

  _launchAR() async {
    if (io.Platform.isAndroid) {
      await NativeArViewer.launchAR(modelURL);
    } else if (io.Platform.isIOS) {
      /// Here File name is hardcoded, in realtime application you will use your own logic to locate USDZ file.
      await NativeArViewer.launchAR("$documentDirectoryPath/Astronaut.usdz");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Platform not supported')));
    }
  }

  Future<void> _prepareSaveDir() async {
    documentDirectoryPath = (await _findLocalPath())!;
    final savedDir = io.Directory(documentDirectoryPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Augmented Reality'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _launchAR,
                child: const Text(
                  'Launch AR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void downloadCallback(
//     String id, DownloadTaskStatus status, int progress) async {
//   print('callback: ID = $id || status = $status || progress = $progress');
// }


void downloadCallback(
  String id, int status, int progress) async {
  print('callback: ID = $id || status = $status || progress = $progress');
}
