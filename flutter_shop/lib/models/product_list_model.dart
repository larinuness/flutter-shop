import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_model.dart';

//ChangeNotifier executa conforme acontece a mudança
//NotifyListeners avisa que teve mudança
class ProductList with ChangeNotifier {
  final List<Product> _items = [];
  final _baseUrl =
      'https://shop-cod3r-flutter-default-rtdb.firebaseio.com/products';

  //retorna um clone de items(nova lista) pra não ter acesso
  //direto ao _items
  List<Product> get items => [..._items];

  //retorna a lista apenas com os produtos favoritos
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  //pega a quandiade de items
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
  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  //editar um produto
  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  //deleta um produto
  removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  //carrega produtos do firebase
  Future<void> loadProduct() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('$_baseUrl.json'),
    );
    //se for nulo não retorna nada
    // ignore: avoid_returning_null_for_void, unnecessary_null_comparison
    if (response.body == null) return null;
    Map<String, dynamic> data = json.decode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        //pega dados do map
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  //add produto
  Future<void> addProduct(Product product) async {
    //no Realtime do firebase tem que terminar com .json
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      //json.encode converte o produto pra um json
      //passa um Map
      body: json.encode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    //json.decode converte o json pra um objeto
    final id = json.decode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );
    //Avisa que teve mudança
    notifyListeners();
  }
}
