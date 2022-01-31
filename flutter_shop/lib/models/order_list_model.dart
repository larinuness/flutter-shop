import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'cart_item_model.dart';
import 'order_model.dart';
import 'package:http/http.dart' as http;
import 'cart_model.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  //retorna clone de _items
  List<Order> get items {
    return [..._items];
  }

  int get itemsCount => _items.length;

  //transforma o carrinho em um pedido
  Future<void> addOrder(
    Cart cart,
  ) async {
    //no Realtime do firebase tem que terminar com .json
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.orderUrl}.json'),
      //json.encode converte o produto pra um json
      //passa um Map
      body: json.encode(
        {
          "total": cart.totalCart,
          "date": date.toIso8601String(),
          "products": cart.items.values
              .map((cartItem) => {
                    "id": cartItem.id,
                    "productId": cartItem.productId,
                    "name": cartItem.name,
                    "quantity": cartItem.quantity,
                    "price": cartItem.price,
                  })
              .toList(),
        },
      ),
    );
    final id = json.decode(response.body)['name'];
    _items.insert(
      0,
      Order(
          id: id,
          total: cart.totalCart,
          //pega os valores do map de items e transforma em uma lista
          products: cart.items.values.toList(),
          date: date),
    );
    notifyListeners();
  }

  //carrega pedidos do firebase
  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.orderUrl}.json'),
    );
    //se for nulo não retorna nada
    // ignore: avoid_returning_null_for_void, unnecessary_null_comparison
    if (response.body == null) return null;
    Map<String, dynamic> data = json.decode(response.body);
    data.forEach((orderId, orderData) {
      //insert e o 0,pq add no topo da lista
      //add insere no final da lista
      _items.insert(
        0,
        //pega dados do map
        Order(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price'],
                productId: item['productId'],
              );
            }).toList()),
      );
    });
    notifyListeners();
  }
}
