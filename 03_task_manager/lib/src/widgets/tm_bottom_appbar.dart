import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_manager/src/data/constants.dart';
import 'package:tasks_manager/src/utils/screen_util.dart';

class TMBottomAppBar extends StatefulWidget {
  final List<String> items;
  final Function(int) onIndexChanged;
  const TMBottomAppBar({
    Key key,
    @required this.items,
    @required this.onIndexChanged,
  }) : super(key: key);

  @override
  TMBottomAppBarState createState() {
    return new TMBottomAppBarState();
  }
}

class TMBottomAppBarState extends State<TMBottomAppBar> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return BottomAppBar(
          elevation: 0.0,
          color: Colors.white,
          child: Builder(
            builder: (BuildContext context) {
              return Container(
                foregroundDecoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.screen,
                  gradient: new LinearGradient(
                    begin: Alignment(0.0, -0.6),
                    end: Alignment(0.00, 1.0),
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.3),
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: ScreenUtil().setSp(1) / 2,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
                height: constraints.maxHeight < 650
                    ? ScreenUtil().setSp(60)
                    : ScreenUtil().setSp(80),

                child: Row(
                  children: _buildItems(widget.items),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<TMButtomAppBarItem> _buildItems(List<String> items) {
    List<TMButtomAppBarItem> _ = [];

    items.asMap().forEach((int index, String item) {
      _.add(TMButtomAppBarItem(
        assetIcon: item,
        isActive: index == currentIndex,
        onPressed: () {
          widget.onIndexChanged(index);
          setState(() {
            currentIndex = index;
          });
        },
      ));
    });

    return _;
  }
}

class TMButtomAppBarItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetIcon;
  final bool isActive;
  const TMButtomAppBarItem({
    Key key,
    @required this.assetIcon,
    @required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.all(0.0),
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color:
                isActive ? AppColors.lightGrey.withOpacity(0.15) : Colors.white,
            border: Border(
              right: BorderSide(
                width: ScreenUtil().setSp(1) / 2,
                color: AppColors.lightGrey,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            assetIcon,
            height: ScreenUtil().setSp(15),
            width: ScreenUtil().setSp(15),
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
