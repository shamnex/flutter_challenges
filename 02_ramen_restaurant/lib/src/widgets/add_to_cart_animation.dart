import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/data/constants.dart';

class AddToCartAnimation extends StatelessWidget {
  final Animation<double> _opacity;
  final Animation<double> _sizeAnimation;
  final Animation<Offset> _offset;
  final AnimationController _animationController;

  AddToCartAnimation({
    Key key,
    @required AnimationController animationController,
    @required Offset begin,
    @required Offset end,
  })  : _animationController = animationController,
        _offset = Tween(
          begin: begin,
          end: end,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.0,
              1.0,
            ),
          ),
        ),
        _opacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.0,
              0.05,
            ),
            reverseCurve: Interval(
              0.0,
              1.0,
            ),
          ),
        ),
        _sizeAnimation = Tween(
          begin: 60.0,
          end: 18.0,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.0,
              1.0,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext ctx, Widget child) {
        return Transform.translate(
          child: Opacity(
            opacity: _opacity.value,
            child: IgnorePointer(
              child: Container(
                height: _sizeAnimation.value,
                width: _sizeAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.yellow,
                ),
              ),
            ),
          ),
          offset: _offset.value,
        );
      },
    );
  }
}
