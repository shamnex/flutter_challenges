import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:tasks_manager/src/data/constants.dart';
import 'package:tasks_manager/src/utils/page_view_tranforms.dart';
import 'package:tasks_manager/src/utils/screen_util.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:transformer_page_view/parallax.dart';

class TasksTab extends StatefulWidget {
  @override
  TasksTabState createState() {
    return new TasksTabState();
  }
}

class TasksTabState extends State<TasksTab>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  AnimationController _animationController;
  Animation _moveLeft;

  initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));

    _moveLeft = Tween(begin: 0.0, end: -100).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _controller = PageController(
      initialPage: 1,
      viewportFraction: 0.35,
      keepPage: false,
    )..addListener(() {
        print(_controller.page);
      });
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildAppBar(),
                    _buildTitle(),
                    _buildAddButton(),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.identity()..translate(0.0),
                height: ScreenUtil().setSp(270),
                child: OverflowBox(
                  minWidth: ScreenUtil.screenWidthDp + 100,
                  maxWidth: ScreenUtil.screenWidthDp + 100,
                  alignment: Alignment.centerLeft,
                  child: PageView.custom(
                    controller: _controller,
                    pageSnapping: true,
                    onPageChanged: (page) {
                      print(page);
                      if (page == 0) {
                        _controller.animateToPage(1,
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 400));
                      }
                    },
                    childrenDelegate:
                        SliverChildBuilderDelegate((context, int) {
                      if (int == 0) {
                        return Container();
                      }
                      return Transform.translate(
                        offset:
                            Offset(-ScreenUtil.screenWidthDp * .35 + 20.0, 0),
                        child: TasksCard(
                          items: [
                            new TaskItem(
                              isCompleted: true,
                            ),
                            new TaskItem(),
                            new TaskItem(),
                            new TaskItem(),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setSp(10)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(20),
          ),
          child: Image.asset(
            AppImages.logo,
            height: ScreenUtil().setSp(20),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Divider(
              height: ScreenUtil().setSp(1) / 2,
              color: AppColors.lightGrey,
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              child: RichText(
                text: TextSpan(
                  text: "Tasks",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: ScreenUtil().setSp(28),
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
          ),
          Flexible(
            flex: 1,
            child: Divider(
              height: ScreenUtil().setSp(1) / 2,
              color: AppColors.lightGrey,
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
            alignment: Alignment.center,
            height: ScreenUtil().setSp(50),
            width: ScreenUtil().setSp(50),
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
                  color: AppColors.lightGrey, width: ScreenUtil().setSp(1) / 2),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Add List",
          style: TextStyle(
            color: AppColors.lightGrey,
            fontSize: ScreenUtil().setSp(12),
          ),
        )
      ],
    );
  }
}

class TasksCard extends StatelessWidget {
  const TasksCard({Key key, @required this.items}) : super(key: key);

  final List<TaskItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setSp(270),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setSp(30),
            ScreenUtil().setSp(50),
            ScreenUtil().setSp(0),
            ScreenUtil().setSp(20)),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(6)),
        width: ScreenUtil().setSp(150),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.red),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "My Tasks",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w700),
            ),
            Divider(
              color: Colors.white,
              height: ScreenUtil().setSp(30),
            ),
          ]..addAll(items),
        ));
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    this.isCompleted = false,
    Key key,
  }) : super(key: key);

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: isCompleted ? 0.4 : 1.0,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setSp(14),
                  width: ScreenUtil().setSp(14),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: isCompleted ? Colors.transparent : Colors.white,
                        width: ScreenUtil().setSp(1),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          ScreenUtil().setSp(3),
                        ),
                      )),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(10),
                ),
                Flexible(
                  child: Text(
                    "Buy Milk",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setSp(20)),
          child: Divider(
            color: isCompleted ? Colors.white : Colors.transparent,
          ),
        )
      ],
    );
  }
}
