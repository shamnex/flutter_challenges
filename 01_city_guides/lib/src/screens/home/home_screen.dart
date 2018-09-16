import 'package:challenges/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'tabs/expolore_tab.dart';
import 'tabs/location_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  final List<Widget> _tabs = [
    ExploreTab(),
    LocationTab(),
    ProfileTab(),
  ];

  Widget _currentTab;

  @override
  initState() {
    changeTab(_currentTabIndex);
    super.initState();
  }

  changeTab(int index) {
    _currentTabIndex = index;
    _currentTab = _tabs[_currentTabIndex];
  }

  Widget build(BuildContext ctx) {
    return Scaffold(
      body: _currentTab,
      bottomNavigationBar: buildBottomNavigation(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBottomNavigation() {
    return BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildItemList(
              [
                IconImage.compass,
                IconImage.location,
                IconImage.user,
              ],
            )));
  }

  List<Widget> buildItemList(List<String> items) {
    final List<Widget> _ = [];
    items
        .asMap()
        .forEach((index, item) => _.add(buildItem(item, index)));

    return _;
  }

  Widget buildItem(String iconLink, int index) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          changeTab(index);
        });
      },
      child: Container(
        height: 41.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 4.0,
              height: 4.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: _currentTabIndex == index
                    ? AppColors.darkGrey
                    : Colors.transparent,
              ),
            ),
            Image.asset(
              iconLink,
              color: _currentTabIndex == index
                  ? AppColors.darkGrey
                  : AppColors.lightGrey,
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
