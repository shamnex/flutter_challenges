import 'package:challenges/src/models/destination.dart';
import 'package:challenges/src/widgets/app_icon.dart';
import 'package:challenges/src/widgets/destination_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:challenges/data/constants.dart';

class ExploreTab extends StatefulWidget {
  @override
  ExploreTabState createState() {
    return new ExploreTabState();
  }
}

class ExploreTabState extends State<ExploreTab> with TickerProviderStateMixin {
  final _searchFocusNode = FocusNode();
  final List<Destination> _destinations = Destination.generate();

  AnimationController controller;
  Animation<double> opacity;
  Animation<double> slideUp;
  Animation<double> scale;

  @override
  initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900))
          ..addStatusListener((status) {
            //     if (status == AnimationStatus.completed) {
            //    controller.reverse();
            //  } else if (status == AnimationStatus.dismissed) {
            //    controller.forward();
            //  }
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
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    slideUp = Tween<double>(
      begin: 200.0,
      end: 40.0,
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
          curve: Cubic(1.0, .37, .15, .82),
        ),
      ),
    );
    scale = Tween<double>(
      begin: 40.0,
      end: double.infinity,
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
          curve: Cubic(1.0, .37, .15, .82),
        ),
      ),
    );

    super.initState();
    _searchFocusNode.addListener(() {
      // if (_searchFocusNode.hasFocus) {
      //   // Navigator.pushNamed(context, "/search");
      //   // FocusScope.of(context).requestFocus(node)
      // }else if (!_searchFocusNode.hasFocus) {
      // }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      buildSearchBar(),
      buildTopBar(),
      buildPageView(),
    ]);
  }

  Widget buildSearchBar() {
    return Hero(
      tag: "SearchBar",
      child: Material(
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          margin: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 10.0),
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  border: InputBorder.none,
                  filled: false,
                  fillColor: Colors.white,
                  errorText: null,
                  hintStyle:
                      TextStyle(color: AppColors.lightGrey, fontSize: 12.0),
                  errorStyle: TextStyle(),
                  hintText: 'Where do you want to go?',
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: AppColors.bodyText,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.transparent,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/search");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            child: Row(children: [
              Text(
                "DESTINATIONS",
                style: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                    fontSize: 14.0),
              ),
              RotatedBox(
                child: new Icon(
                  CupertinoIcons.left_chevron,
                  size: 12.0,
                ),
                quarterTurns: 3,
              ),
            ]),
            onPressed: () {},
          ),
          CupertinoButton(
            child: AppIcon(
              size: 16.0,
              image: IconImage.controls,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.885),
        itemCount: _destinations.length,
        itemBuilder: (BuildContext context, int index) {
          Destination currentDestination = _destinations[index];
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "destination$index");
              },
              child: DestinationCard(destination: currentDestination));
        },
      ),
    );
  }
}
