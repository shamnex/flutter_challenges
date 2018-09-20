import 'dart:async';
import 'package:flutter/material.dart';

class CartBloc {
  StreamController<int> _items = StreamController<int>.broadcast();
  //getters
  Stream<int> get items => _items.stream;
  int _total = 0;
  int get total => _total;

  Function(int) get addItem => _items.sink.add;

  CartBloc() {
    addItem(0);

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
