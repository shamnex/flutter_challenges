import 'package:flutter/material.dart';
import 'package:tasks_manager/src/screens/home_screen.dart';
import 'package:tasks_manager/src/utils/screen_util.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
