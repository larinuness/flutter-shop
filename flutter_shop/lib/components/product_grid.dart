import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_list.dart';
import '../models/product_model.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
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
        return ChangeNotifierProvider(
          create: (_) => loadedProducts[index],
          child: ProductItem(),
        );
      },
    );
  }
}
