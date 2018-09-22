import 'package:ramen_restaurant/src/data/constants.dart';

class Food {
  final int price;
  final String name;
  final String image;

  const Food({this.image, this.name, this.price});

  static List<Food> getAllFoods() {
    return [
      Food(
        name: "White Rice and Dodo",
        image: Images.white,
        price: 1500,
      ),
      Food(
        name: "Jollof Rice",
        image: Images.jollof,
        price: 2000,
      ),
      Food(
        name: "Beans and Dodo",
        image: Images.beans,
        price: 1500,
      ),
      Food(
        name: "Indomie Noodles",
        image: Images.indomie,
        price: 2500,
      ),
      Food(
        name: "Amala and Ewedu",
        image: Images.amala,
        price: 3500,
      ),
    ];
  }
}
