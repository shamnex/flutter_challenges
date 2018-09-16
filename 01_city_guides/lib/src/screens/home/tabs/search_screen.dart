import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:challenges/data/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() {
    return new SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  Animation<double> slideDown;

  Animation<double> opacity;
  Animation<double> scale;

  AnimationController controller;

  final StreamController<bool> _isAnimating = new StreamController.broadcast();
  Stream<bool> get isAnimating => _isAnimating.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..addStatusListener((status) {
            if (status == AnimationStatus.forward ||
                status == AnimationStatus.reverse) {
              _isAnimating.sink.add(true);
            } else if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              _isAnimating.sink.add(false);
            }
          });

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    slideDown = Tween<double>(
      begin: -70.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(1.0, .37, .15, .82),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Cubic(1.0, .37, .15, .82),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    _isAnimating.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: opacity,
            child: Container(
              padding: EdgeInsets.only(top: 30.0),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width - 40.0,
              child: StreamBuilder(
                stream: isAnimating,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return CupertinoButton(
                      child: Icon(Icons.close),
                      disabledColor: Colors.red,
                      onPressed: () {
                        if (!snapshot.hasData) return null;
                        if (!snapshot.data) {
                          controller.reverse();

                          Future.delayed(Duration(milliseconds: 300), () {
                            Navigator.pop(context);
                          });
                        }
                      });
                },
              ),
            ),
            builder: (BuildContext context, Widget child) {
              return Opacity(
                child: child,
                opacity: opacity.value,
              );
            },
          ),
          AnimatedBuilder(
            animation: opacity,
            child: Container(
              padding: EdgeInsets.only(top: 40.0),
              alignment: Alignment.center,
              child: AnimatedBuilder(
                  animation: opacity,
                  builder: (BuildContext context, Widget child) {
                    return SingleChildScrollView(
                      child: Container(
                        height: scale.value == 0 || scale.value > 0.3
                            ? 50.0
                            : MediaQuery.of(context).size.height - 130.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0),
                          ),

                          // border: Border.all(color: Colors.red, width: 0.5),

                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 18.0),
                          ],
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            border: InputBorder.none,
                            errorText: null,
                            hintStyle: TextStyle(
                                color: AppColors.lightGrey, fontSize: 12.0),
                            errorStyle: TextStyle(),
                            hintText: 'Where do you want to go?',
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: AppColors.bodyText,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            builder: (BuildContext ctx, Widget child) {
              return Transform(
                transform: Matrix4.identity()..translate(0.0, slideDown.value),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
