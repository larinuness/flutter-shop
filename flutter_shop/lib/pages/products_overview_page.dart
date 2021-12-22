import 'package:flutter/material.dart';

import '../components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductGrid(),
      ),
    );
  }
}


