import 'package:flutter/material.dart';

class BounceInAnimation extends StatefulWidget {
  final Widget _child;
  final bool _replayable;
  final Duration _duration;
  BounceInAnimation(
      {Key key,
      @required Widget child,
      bool replayable = false,
      Duration duration})
      : _child = child,
        _replayable = replayable,
        _duration = duration,
        super(key: key);
  @override
  BounceInAnimationState createState() {
    return BounceInAnimationState();
  }
}

class BounceInAnimationState extends State<BounceInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget._duration ?? Duration(milliseconds: 800),
    );

    scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: ElasticOutCurve(0.2),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.status == AnimationStatus.completed) {
      if (widget._replayable) {
        controller.reset();
        controller.forward();
      }
    } else {
      controller.forward();
    }

    return AnimatedBuilder(
      animation: scale,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: scale.value,
          child: widget._child,
        );
      },
    );
  }
}
