import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    @required this.image,
    this.color,
    this.size,
    Key key,
  }) : super(key: key);

  final image;
  final color;
  final size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: size == null? 12.0: size,
      color: color,
    );
  }
}