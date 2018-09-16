import 'package:flutter/material.dart';

class SlideUpAnimation extends StatefulWidget {
  final Widget child;
  final double from;
  final double to;
  final Duration duration;
  final Curve curve;
  SlideUpAnimation({
    Key key,
    this.from,
    this.to,
    this.duration,
    this.curve,
    @required this.child,
  }) : super(key: key);

  SlideUpAnimationState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<SlideUpAnimationState>());

  @override
  SlideUpAnimationState createState() {
    return new SlideUpAnimationState();
  }

  static AnimationController _controller;
  set setController(AnimationController controller) => _controller = controller;
  AnimationController get controller => _controller;
}

class SlideUpAnimationState extends State<SlideUpAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> opacity;
  Animation<double> slideUp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          Duration(
            milliseconds: 800,
          ),
    );

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    slideUp = Tween<double>(
      begin: widget.from ?? 200.0,
      end: widget.to ?? 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          1.0,
          // curve: Cubic(.69,.73,.11,1.0),
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
          curve: Cubic(.69,.73,.11,1.0),
        ),
      ),
    );
  }

  Function get animateForward => _controller.forward;
  Function get animateBackward => _controller.reverse;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animateForward();

    return AnimatedBuilder(
      child: widget.child,
      animation: opacity,
      builder: (BuildContext context, Widget child) {
        widget.setController = widget.of(context)._controller;
        return Opacity(
          opacity: opacity.value,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, slideUp.value),
            child: child,
          ),
        );
      },
    );
  }
}
