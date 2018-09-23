import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/blocs/app_bloc.dart';
import 'package:ramen_restaurant/src/data/constants.dart';
import 'package:ramen_restaurant/src/models/food.dart';
import 'package:ramen_restaurant/src/widgets/add_to_cart_animation.dart';
import 'package:ramen_restaurant/src/widgets/bounce_in_animation.dart';
import 'package:ramen_restaurant/src/widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final foodCardHeight = 360.0; // retrieved from food_card.dart
  double screenHeight;
  double screenWidth;

  double yStartPosition; //
  double yEndPosition;

  double xStartPosition;
  double xEndPosition;

  PageController _pageViewController = PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 0.7,
  );

  AnimationController _addToCardController;
  AnimationController _fadeInController;
  Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _addToCardController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              _addToCardController.reset();
            }
          });

    _fadeInController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeInController,
        curve: Curves.linear,
      ),
    );

    _fadeInController.forward();
  }

  final List<Food> _foods = Food.getAllFoods();

  dispose() {
    _addToCardController.dispose();
    _fadeInController.dispose();
    _pageViewController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final bloc = AppProvider.of(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    yStartPosition = screenHeight - foodCardHeight / 2;
    xStartPosition = screenWidth / 2 - 30.0;

    yEndPosition = 18.0 + 10.0;
    xEndPosition = screenWidth - 18.0 - 10.0;

    return Stack(
      children: <Widget>[
        //BACKGROUND ===============================
        _buildBGAnimation(bloc),

        ///sCAFFOLD //===============================
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(bloc),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildSlider(bloc),
              Positioned(
                bottom: 40.0,
                child: Row(
                  children: _buildIndicator(bloc),
                ),
              ),
            ],
          ),
        ),

        //ADD TO Cart ANimation //===============================

        AddToCartAnimation(
          begin: Offset(xStartPosition, yStartPosition),
          end: Offset(xEndPosition, yEndPosition),
          animationController: _addToCardController,
        ),
      ],
    );
  }

  List<Widget> _buildIndicator(AppBloc bloc) {
    final List<Widget> _ = [];
    _foods.asMap().forEach(
      (index, food) {
        _.add(
          StreamBuilder(
            stream: bloc.currentpage,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              int currentPage = snapshot.data ?? 0;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 7.0),
                alignment: Alignment.center,
                color: currentPage == index ? Colors.black : Colors.grey,
                height: 3.0,
                width: 15.0,
              );
            },
          ),
        );
      },
    );

    return _;
  }

  Widget _buildBGAnimation(AppBloc bloc) {
    return Column(children: [
      Expanded(
        child: StreamBuilder(
          stream: bloc.bgColor,
          builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: BGColors.all[0],
              );
            }
            return Container(
              color: snapshot.data,
            );
          },
        ),
      ),
      Expanded(
        child: Container(
          color: Color(0xFFffffff),
        ),
      ),
    ]);
  }

  Widget buildAppBar(AppBloc bloc) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {},
      ),
      backgroundColor: Colors.transparent,
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
                stream: bloc.itemsInCart,
                builder: (ctx, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData) {
                    return BounceInAnimation(
                      replayable: true,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                        ),
                        margin: const EdgeInsets.only(right: 10.0),
                        padding: const EdgeInsets.all(4.0),
                        child: Text(bloc.total.toString().toUpperCase(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0)),
                      ),
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
    );
  }

  Widget _buildSlider(AppBloc bloc) {
    return StreamBuilder(
      stream: bloc.currentpage,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return AnimatedBuilder(
          animation: _fadeIn,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _fadeIn.value,
              child: PageView.builder(
                controller: _pageViewController,
                itemCount: _foods.length,
                onPageChanged: (int pageNumber) =>
                    bloc.setCurrentPage(pageNumber),
                itemBuilder: (BuildContext context, int index) {
                  final Food currentFood = _foods[index];
                  return AnimatedBuilder(
                    animation: _pageViewController,
                    child: GestureDetector(
                      onTap: null,
                      child: FoodCard(
                        food: currentFood,
                        onAddToCart: (int quantity) async {
                          await _addToCardController.forward();
                          bloc.addItemsToCart(quantity);
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
            );
          },
        );
      },
    );
  }
}
