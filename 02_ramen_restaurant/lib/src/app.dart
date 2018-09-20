import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/blocs/cart_bloc.dart';
import 'package:ramen_restaurant/src/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(),
        buttonTheme: ButtonThemeData(),
        iconTheme: IconThemeData(color: Colors.black),
        primaryColor: Colors.grey,
      ),
      title: "New App",
      home: CartProvider(child: HomeScreen()),
    );
  }
}
