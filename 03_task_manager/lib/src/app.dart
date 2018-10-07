import 'package:flutter/material.dart';
import 'package:tasks_manager/src/screens/home_screen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
      ),
      home: HomeScreen(),
    );
  }
}
