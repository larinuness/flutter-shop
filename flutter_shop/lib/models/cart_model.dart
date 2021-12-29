import 'dart:math';

import 'package:flutter/material.dart';

import 'cart_item_model.dart';
import 'product_model.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product product) {
    //checa se já existe o produto no carrrinho
    if (_items.containsKey(product.id)) {
      //atualiza os valores em vez de criar um novo
      //assim poder tem varias quantidade do mesmo item
      //apenas mudando o quantity e o price
      _items.update(
        product.id,
        (itemExistent) => CartItem(
            id: itemExistent.id,
            productId: itemExistent.productId,
            name: itemExistent.name,
            quantity: itemExistent.quantity + 1,
            price: itemExistent.price),
      );
      //se não tiver ja no carrinho, insere como um novo
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: product.id,
              name: product.name,
              //1 pq vai ser a primeira vez
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    //um novo map vazio
    _items = {};
    notifyListeners();
  }
}
