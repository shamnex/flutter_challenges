import 'package:ramen_restaurant/src/data/constants.dart';

class Food {
  final int price;
  final String name;
  final String image;

  const Food({this.image, this.name, this.price});

  static List<Food> getAllFoods() {
    return [
      Food(
        name: "TuwoShinkafa Rice",
        image: Images.jollof,
        price: 100,
      ),
      Food(
        name: "Jollof Rice",
        image: Images.jollof,
        price: 100,
      ),
      Food(
        name: "White Rice and Stew",
        image: Images.jollof,
        price: 100,
      ),
      Food(
        name: "Chinese Something",
        image: Images.jollof,
        price: 25,
      ),
      Food(
        name: "Oyibo Rice",
        image: Images.jollof,
        price: 60,
      ),
    ];
  }
}
