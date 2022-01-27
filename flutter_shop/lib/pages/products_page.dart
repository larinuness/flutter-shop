import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/product_item.dart';
import '../models/product_list_model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  Future<void> refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productsForm);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(
                  product: products.items[i],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
