import 'dart:async';
import 'package:flutter/material.dart';

class CartBloc {
  StreamController<int> _items = StreamController<int>.broadcast();
  int _total = 0;

  //getters
  Stream<int> get items => _items.stream;
  int get total => _total;
  //getters
  Function(int) get addItem => _items.sink.add;

  CartBloc() {
    _items.stream.listen((onData) {
      _total += onData;
    });
  }

  dispose() {
    _items.close();
  }
}

class CartProvider extends InheritedWidget {
  updateShouldNotify(_) => true;
  CartProvider({Key key, Widget child}) : super(key: key, child: child);

  final bloc = CartBloc();

  static CartBloc of(context) {
    return (context.inheritFromWidgetOfExactType(CartProvider) as CartProvider)
        .bloc;
  }
}
