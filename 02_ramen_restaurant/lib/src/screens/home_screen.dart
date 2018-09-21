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

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController _pageViewController;

  AnimationController _animationController;
  Animation<double> _opacity;

  int _currentpage;
  Color _bgColor;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addStatusListener((status) {
            print(status);
          });

    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          1.0,
        ),
        reverseCurve: Interval(
          0.0,
          1.0,
        ),
      ),
    );

    _animationController.forward();

    _currentpage = 0;
    _pageViewController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 0.7,
    )..addListener(() {});

    // _animationController.forward();

    _bgColor = BGColors.all[_currentpage];
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
        backgroundColor: _bgColor,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 6.0,
                right: 0.0,
                child: StreamBuilder(
                  stream: cartBloc.items,
                  builder: (ctx, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.yellow),
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Text(cartBloc.total.toString().toUpperCase(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0)),
                      );
                    }
                    return Container();
                  },
                ),
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
            AnimatedBuilder(
              animation: _opacity,
              builder: (BuildContext ctx, Widget child) {
                return Expanded(
                  child: Opacity(
                    opacity: _opacity.value,
                    child: Container(
                      color: _bgColor,
                    ),
                  ),
                );
              },
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
            onPageChanged: (int pageNumber) {
              setState(() {
                _currentpage = pageNumber;
                _bgColor = BGColors.all[pageNumber];
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
                builder: (BuildContext ctx, Widget child) {
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
