import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    final extDir = await getExternalStorageDirectory();
    final path = extDir!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  } else {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(file.path);
  }
}