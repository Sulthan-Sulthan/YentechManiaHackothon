import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

enum DownloadStatus { downlaoding, downlaoded, notInQueue }

abstract class Downloader extends ChangeNotifier {
  Future<String?> downloadAssets(String assetUrl, String pathToSave);
  Future<DownloadStatus> getdownloadStatusById(String taskId);
}

class AssetsDownloader extends Downloader {
  AssetsDownloader();

  @override
  Future<String?> downloadAssets(String assetUrl, String pathToSave) async =>
      await FlutterDownloader.enqueue(url: assetUrl, savedDir: pathToSave);

  @override
  Future<DownloadStatus> getdownloadStatusById(String taskId) async {
    var tasks = await FlutterDownloader.loadTasks();
    if (tasks != null && tasks.isNotEmpty) {
      return tasks.where((task) => task.taskId == taskId).first.progress == 100
          ? DownloadStatus.downlaoded
          : DownloadStatus.downlaoding;
    }
    return DownloadStatus.notInQueue;
  }
}



