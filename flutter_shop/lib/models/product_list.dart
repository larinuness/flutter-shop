import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product_model.dart';

import '../data/dummy_data.dart';

//ChangeNotifier executa conforme acontece a mudança
//NotifyListeners avisa que teve mudança
class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  //retorna um clone de items(nova lista) pra não ter acesso
  //direto ao _items
  List<Product> get items => [..._items];

  //add produto
  void addProduct(Product product) {
    _items.add(product);
    //Avisa que teve mudança
    notifyListeners();
  }
}
