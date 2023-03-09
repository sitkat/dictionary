import 'package:dictionary/db/data_base_helper.dart';
import 'package:dictionary/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'data_controller.dart';

void main() {
  runApp(const MyApp());
  DataController dataController = DataController();
  dataController.converter();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
