import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_list_model.dart';
import '../models/product_model.dart';
import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context, listen: false);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      //quantidade que vai ter no grid
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //quantidade de item por linha
        crossAxisCount: 2,
        //dimensão de cada elemento, altura e largura
        childAspectRatio: 3 / 2,
        //espacamento no eixo cruzado
        crossAxisSpacing: 10,
        //espacamento no eixo principal
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        //.value pra ja existe um valor
        //sem value, está criando um do 0
        return ChangeNotifierProvider.value(
          //usa os produtos que já foram criados
          value: loadedProducts[index],
          child: const ProductGridtItem(),
        );
      },
    );
  }
}
