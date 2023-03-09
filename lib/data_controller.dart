import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/services.dart' show rootBundle;

class DataController {
  late final Directory _appDirectory;

  void converter() async {
    WidgetsFlutterBinding.ensureInitialized();
    File file = File(_loadFile().toString());
    // print(file);
  }

  Future<dynamic> readFileAsync(String filePath) async {
    String textString = await rootBundle.loadString(filePath);
    // print(textString);
    // LineSplitter.split(textString).forEach((line) => print('$line'));
    return LineSplitter.split(textString).forEach((line) => print('$line'));
    // return textString;
  }
  Future<dynamic> _loadFile() async {
    String data = await rootBundle.loadString('assets/test.txt');
    LineSplitter.split(data).forEach((line) {
      print('$line');
    });
  }
}
