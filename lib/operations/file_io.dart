// ignore_for_file: unnecessary_string_interpolations, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileIO {
  String filePath = "";

  Future<String> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: "Select a .md file for our App",
        type: FileType.custom,
        allowedExtensions: ['md']);

    PlatformFile file;    
    
    if (result == null) {
      return filePath;
    } else {
      file = result.files.single;
      filePath = file.path.toString();
    }

    return file.path.toString();
  }

  Future<String> saveNewFile(String initialDirectory) async {
    String? result = await FilePicker.platform.saveFile(
        dialogTitle: "Save file as",
        initialDirectory: initialDirectory,
        type: FileType.custom,
        allowedExtensions: ['md']);

    return result.toString();
  }

  Future<File> get getFile async {
    String path;
    path = await pickFiles();
    return File('$path');
  }

  Future<File> saveToFile(String data, String currentFilePath) async {
    final file = File(currentFilePath);
    return file.writeAsString(data);
  }

  Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String content = await file.readAsString();
      return content;
    } catch (e) {
      return "";
    }
  }

  String get currentFilePath {
    return filePath;
  }
}
