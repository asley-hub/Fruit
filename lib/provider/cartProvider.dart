import 'package:flutter/material.dart';
import '../classes/fruit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Fruit> _fruits = [];
  double _sum = 0;

  List<Fruit> get items => _fruits;
 
  double get sum => _sum;

  void addFruit(Fruit fruit) {
    _fruits.add(fruit);
    _sum = _sum + fruit.price;

    notifyListeners();
  }

  void removeFruit(Fruit item, [bool notified = true]) {
    _fruits.remove(item);
    _sum = _sum - item.price;

    notifyListeners();
  }

  void removeFruits(Fruit item, [bool notified = true]) {
    while (_fruits.contains(item)) {
      _fruits.remove(item);
      _sum = _sum - item.price;
    }

    notifyListeners();
  }

  void clearCart([bool notified = true]) {
    _fruits.clear();
    _sum = 0;

    notifyListeners();
  }

  int nbFruitCart(Fruit item) {
    int i = 0;
    _fruits.forEach((fruit) {
      if (fruit.name == item.name) {
        i++;
      }
    });

    return i;
  }
}