import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:tasks_manager/src/data/constants.dart';

class TasksTab extends StatefulWidget {
  @override
  TasksTabState createState() {
    return new TasksTabState();
  }
}

class TasksTabState extends State<TasksTab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation bounce;
  PageController _controller;

  initState() {
    _controller = PageController(viewportFraction: 0.4, initialPage: 0);
    _controller.addListener(() {});

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 700,
      ),
    );

    bounce = Tween<Offset>(
      begin: Offset(
        0.0,
        0.0,
      ),
      end: Offset(
        40.0,
        0.0,
      ),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
      ),
    );

    super.initState();
  }

  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildAppBar(screenHeight),
                      _buildTitle(),
                      _buildAddButton(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onHorizontalDragStart: (DragStartDetails details) {},
                    onHorizontalDragUpdate: (DragUpdateDetails details) {
                      print('hello');
                    },
                    onHorizontalDragEnd: (DragEndDetails details) {
                      print('hello');
                    },
                    child: PageView.builder(
                      pageSnapping: true,
                      itemCount: 10,
                      onPageChanged: (int page) {
                        _animationController.forward();
                         
                      },
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedBuilder(
                          animation: _animationController,
                          builder: (BuildContext context, Widget child) {


                            return AnimatedContainer(
                              curve: Curves.elasticIn,
                              // transform: Matrix4.identity()
                              //   ..translate(bounce.value * 20),
                              duration: Duration(
                                milliseconds: 200,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              padding: EdgeInsets.all(20.0),
                              child: Text("data"),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(double screenHeight) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Image.asset(
        AppImages.logo,
        height: 25.0,
      ),
    );
  }

  Widget _buildTitle() {
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
                  fontSize: 26.0,
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

  Widget _buildAddButton() {
    return Column(
      children: <Widget>[
        Container(
          child: Container(
            child: CupertinoButton(
              padding: EdgeInsets.all(6.0),
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: AppColors.black,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(
                color: AppColors.lightGrey,
                width: 0.8,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Add List",
          style: TextStyle(
            color: AppColors.lightGrey,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}
