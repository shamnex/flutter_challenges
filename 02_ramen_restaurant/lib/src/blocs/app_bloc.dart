import 'dart:async';
import 'package:flutter/material.dart';

class AppBloc {
  StreamController<int> _itemsInCart = StreamController<int>.broadcast();
  StreamController<int> _currentpage  =  StreamController<int>.broadcast();

  int _total = 0;
  //getters
  Stream<int> get itemsInCart => _itemsInCart.stream;
  Stream<int> get currentpage => _currentpage.stream;
  int get total => _total;
  //setters
  Function(int) get addItemsToCart => _itemsInCart.sink.add;
  Function(int) get setCurrentPage => _currentpage.sink.add;

  AppBloc() {
    _itemsInCart.stream.listen((onData) {
      _total += onData;
    });
  }

  dispose() {
    _itemsInCart.close();
    _currentpage.close();
  }
}

class AppProvider extends InheritedWidget {
  updateShouldNotify(_) => true;
  AppProvider({Key key, Widget child}) : super(key: key, child: child);

  final bloc = AppBloc();

  static AppBloc of(context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
        .bloc;
  }
}
