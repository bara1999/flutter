import 'package:flutter/material.dart';
import 'package:flutter_app_project/menu.dart';
class Cart extends ChangeNotifier {
  List<Menu> _items = [];
  List<Menu> _favs = [];
  String resName;
  double _totalPrice = 0.0;

  void add(Menu item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  void addfav(Menu fav) {
    _favs.add(fav);

    notifyListeners();
  }

  void remove(Menu item) {
    _totalPrice -= item.price;
    _items.remove(item);
    notifyListeners();
  }

  void removefav(Menu fav) {
    _favs.remove(fav);

    notifyListeners();
  }

void clear(){
    _items.clear();
    notifyListeners();

}
  int get count {
    return _items.length;
  }

  int get countf {
    return _favs.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Menu> get basketItems {
    return _items;
  }
  List<Menu> get favorite {
    return _favs;
  }


}