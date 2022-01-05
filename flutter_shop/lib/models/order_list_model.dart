import 'dart:math';

import 'package:flutter/material.dart';
import 'order_model.dart';

import 'cart_model.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  //retorna clone de _items
  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  //transforma o carrinho em um pedido
  void addOrder(
    Cart cart,
  ) {
    _items.insert(
      0,
      Order(
          id: Random().nextDouble.toString(),
          total: cart.totalCart,
          //pega os valores do map de items e transforma em uma lista
          products: cart.items.values.toList(),
          date: DateTime.now()),
    );
    notifyListeners();
  }
}
