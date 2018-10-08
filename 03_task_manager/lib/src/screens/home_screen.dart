import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_manager/src/data/constants.dart';
import 'package:tasks_manager/src/screens/tabs/burger_tab.dart';
import 'package:tasks_manager/src/screens/tabs/calendar_tab.dart';
import 'package:tasks_manager/src/screens/tabs/tasks_tab.dart';
import 'package:tasks_manager/src/widgets/tm_bottom_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  Widget _currentScreen;

  final _tabs = [
    TasksTab(),
    CalendarTab(),
    BurgerTab(),
  ];

  @override
  void initState() {
    _currentScreen = _tabs[0];
    super.initState();
  }

  final List<String> items = [
    AppIcons.home,
    AppIcons.calender,
    AppIcons.burger,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TMBottomAppBar(
        onIndexChanged: (int index) {
          setState(() {
            _currentScreen = _tabs[index];
          });
        },
        items: items,
      ),
      body: _currentScreen,
    );
  }
}
