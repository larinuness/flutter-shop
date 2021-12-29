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

  //add produto
  void addProduct(Product product) {
    _items.add(product);
    //Avisa que teve mudança
    notifyListeners();
  }
}
