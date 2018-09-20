import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/blocs/cart_bloc.dart';
import 'package:ramen_restaurant/src/data/constants.dart';
import 'package:ramen_restaurant/src/models/food.dart';
import 'package:ramen_restaurant/src/widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  PageController _pageViewController;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(
      initialPage: currentpage,
      keepPage: true,
      viewportFraction: 0.7,
    );
  }

  final List<Food> _foods = Food.getAllFoods();

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Color(0xFFf2e8da),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.shopping_cart),
              ),
              StreamBuilder(
                stream: cartBloc.items,
                builder: (ctx, AsyncSnapshot<int> snapshot) {
                    print(snapshot.data);
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(color: AppColors.yellow),
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Text(cartBloc.total.toString().toUpperCase(),style: TextStyle(color: Colors.white,)),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ],
        title: Text(
          'TODAY\'S SPECIAL',
          style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
        ),
      ),
      body: Stack(
        children: <Widget>[
          //main background
          Column(children: [
            Expanded(
              child: Container(
                color: Color(0xFFf2e8da),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFFffffff),
              ),
            ),
          ]),

          PageView.builder(
            controller: _pageViewController,
            itemCount: _foods.length,
            onPageChanged: (int value) {
              setState(() {
                currentpage = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              final Food currentFood = _foods[index];
              return AnimatedBuilder(
                animation: _pageViewController,
                child: GestureDetector(
                  onTap: null,
                  child: FoodCard(
                    food: currentFood,
                    onAddToCart: (int quantity) {
                      cartBloc.addItem(quantity);
                    },
                  ),
                ),
                builder: (ctx, child) {
                  double value = 1.0;

                  if (_pageViewController.position.haveDimensions) {
                    value = _pageViewController.page - index;
                    value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
                  }
                  return new Transform.scale(
                    // scale: 1.0,
                    scale: Curves.easeOut.transform(value) * 1 + 0.08,
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
