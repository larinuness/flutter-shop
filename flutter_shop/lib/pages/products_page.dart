import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/product_item.dart';
import '../models/product_list_model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.productsForm);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ProductItem(product: products.items[index]),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
