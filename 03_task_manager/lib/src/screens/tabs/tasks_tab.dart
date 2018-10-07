import "package:flutter/material.dart";
import 'package:tasks_manager/src/data/constants.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            _buildAppBar(screenHeight),
            _buildTitle(screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double screenHeight) {
    return Container(
      height: screenHeight / 4.5,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Image.asset(
        AppImages.logo,
        height: 40.0,
      ),
    );
  }

  Widget _buildTitle(double screenHeight) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              text: TextSpan(
                text: "Tasks",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                ),
                children: [
                  TextSpan(
                      text: " Lists",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.lightGrey))
                ],
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
