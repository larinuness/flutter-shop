import 'package:flutter/material.dart';
import '../components/product_item.dart';
import '../models/product_model.dart';
import '../data/dummy_data.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> products = dummyProducts;
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          //quantidade que vai ter no grid
          itemCount: products.length,
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
            return ProductItem(product: products[index]);
          },
        ),
      ),
    );
  }
}
