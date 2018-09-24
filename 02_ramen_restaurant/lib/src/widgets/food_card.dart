import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/data/constants.dart';
import 'package:ramen_restaurant/src/models/food.dart';
import 'package:ramen_restaurant/src/widgets/bounce_in_animation.dart';

class FoodCard extends StatefulWidget {
  final Function(int) onAddToCart;
  final Food food;

  FoodCard({
    Key key,
    @required this.food,
    @required this.onAddToCart,
  }) : super(key: key);

  @override
  FoodCardState createState() {
    return new FoodCardState();
  }
}

class FoodCardState extends State<FoodCard> {
  int _quantity;

  _addQuantity() {
    setState(() {
      _quantity++;
    });
  }

  _removeQuantity() {
    if (_quantity >= 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  initState() {
    super.initState();
    _quantity = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCard(context),
        Transform(
          child: buildButton(),
          transform: Matrix4.identity()..translate(0.0, -30.0),
        ),
        //buttton
      ],
    );
  }

  Widget buildCard(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: <Widget>[
        //=================================================
        //shadow
        //=================================================

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: 360.0,
          width: MediaQuery.of(context).size.width / 1.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0.0, 40.0),
                spreadRadius: 15.0,
                blurRadius: 40.0,
              )
            ],
          ),
        ),
        //====================================================
        //Card
        //=================================================
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 360.0,
            minHeight: 360.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 160.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.food.name.toUpperCase(),
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22.0, height: 1.2),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 90.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    "₦${widget.food.price}",
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _removeQuantity,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: 80.0,
                        // margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.grey, width: 2.0),
                          color: Colors.transparent,
                        ),
                        child: BounceInAnimation(
                          replayable: true,
                          duration: Duration(seconds: 1),
                          child: Text(
                            _quantity.toString(),
                            style: TextStyle(
                                fontSize: 17.0, color: Colors.grey.shade900),
                          ),
                        )),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addQuantity,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

        //=================================================
        //image
        //=================================================

        Transform(
          child: Image.asset(
            widget.food.image,
            height: 130.0,
          ),
          transform: Matrix4.identity()..translate(0.0, -180.0),
        ),
      ],
    );
  }

  Widget buildButton() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        InkWell(
          onTap: _quantity > 0
              ? () async {
                  widget.onAddToCart(_quantity);

                  setState(() {
                    _quantity = 0;
                  });
                }
              : null,
          child: _quantity > 0
              ? BounceInAnimation(
                  child: Container(
                    height: 60.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  height: 60.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}
