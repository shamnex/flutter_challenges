import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ramen_restaurant/src/data/constants.dart';

class AppBloc {
  int _total = 0;
  final List<Color> colors = BGColors.getAll();
  int _bgColorIndex = 0;

  //streams
  StreamController<int> _itemsInCart = StreamController<int>.broadcast();
  StreamController<int> _currentpage = StreamController<int>.broadcast();
  StreamController<Color> _bgColor = StreamController<Color>.broadcast();

  //getters
  Stream<int> get itemsInCart => _itemsInCart.stream;
  Stream<int> get currentpage => _currentpage.stream;
  Stream<Color> get bgColor => _bgColor.stream;
  int get total => _total;
  //setters
  Function(int) get addItemsToCart => _itemsInCart.sink.add;
  Function(int) get setCurrentPage => _currentpage.sink.add;

  AppBloc() {
    _itemsInCart.stream.listen((onData) {
      _total += onData;
    });

    _currentpage.stream.listen((_) {
      //get random Number
      int _randomNumber = Random().nextInt(colors.length);
      while (_randomNumber == _bgColorIndex) {
        _randomNumber = Random().nextInt(colors.length);
      }
      _bgColor.sink.add(colors[_randomNumber]);
      _bgColorIndex = _randomNumber;
    });
  }

  dispose() {
    _itemsInCart.close();
    _currentpage.close();
    _bgColor.close();
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
