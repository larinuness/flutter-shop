import 'dart:math';

import 'package:flutter/material.dart';
import 'product_model.dart';

import '../data/dummy_data.dart';

//ChangeNotifier executa conforme acontece a mudança
//NotifyListeners avisa que teve mudança
class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  int get itemsCount {
    return _items.length;
  }
  // bool _showFavoriteOnly = false;

  // //retorna um clone de items(nova lista) pra não ter acesso
  // //direto ao _items
  // List<Product> get items {
  //   if (_showFavoriteOnly) {
  //     //se for true retorna a lista de produtos favoritos
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }
  //   //se for false retorna a lista clonado com os produtos sem filtro
  //   return [..._items];
  // }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
  
  //criar um produto novo através do form
  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }
  
  //editar um produto
  updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  //deleta um produto
  removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  //add produto
  void addProduct(Product product) {
    _items.add(product);
    //Avisa que teve mudança
    notifyListeners();
  }
}
