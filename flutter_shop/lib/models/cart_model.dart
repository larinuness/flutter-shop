import 'dart:math';

import 'package:flutter/material.dart';

import 'cart_item_model.dart';
import 'product_model.dart';

class Cart with ChangeNotifier {
  //_items = pedido, está como map
  //String seria o id, e CartItem seria o produto
  //então, pedido do id 1 tem tal produto(s)
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  //quantidade total do carrinho(preço)
  double get totalCart {
    double total = 0.0;
    //pra cada elemento(produto) pega o preço e multiplica pela quantidade
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  //function de add um produto do carrinho
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
      //colocar se estiver sem nada do tipo
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

  //remove o item inteiro
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //remove apenas um item
  void removeSingleItem(String productId) {
    //checa se tem o produto dentro da lista de produtos
    //não faz nenhuma ação
    if (!_items.containsKey(productId)) {
      return;
    }
    //se quantidade for igual a 1 remove o item inteiro
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
      // se for maior que 1 remove apenas o ultimo que foi adicionado
    } else {
      _items.update(
        productId,
        (itemExistent) => CartItem(
            id: itemExistent.id,
            productId: itemExistent.productId,
            name: itemExistent.name,
            quantity: itemExistent.quantity - 1,
            price: itemExistent.price),
      );
    }
    notifyListeners();
  }

  void clear() {
    //um novo map vazio
    _items = {};
    notifyListeners();
  }
}
