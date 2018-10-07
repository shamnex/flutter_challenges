import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color purple = const Color(0xFF3B2995);
  static const Color red = const Color(0xFFde3434);
  static const Color brown = const Color(0xFFc7a682);
  static const Color lightGrey = const Color(0xFFa6a6a6);
  static const Color black = const Color(0xFF343434);
}

class BGColors {
  static List<Color> getAll() {
    return [
      const Color(0xFFf2e8da),
      const Color(0xFFefefe7),
      const Color(0xFFd2da75),
      const Color(0xFFf7f7f7),
    ];
  }
}

class AppImages {
  static const logo = "assets/graphics/logo.png";
}
class AppIcons {
  static const home = "assets/icons/home.png";
  static const calender = "assets/icons/calender.png";
  static const burger = "assets/icons/burger.png";
}
