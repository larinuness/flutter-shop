import 'package:flutter/material.dart';

import '../components/product_grid.dart';

enum FilterFavorites { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.menu_outlined),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilterFavorites.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterFavorites.all,
              ),
            ],
            onSelected: (FilterFavorites selectedValue) {
              setState(() {
                if (selectedValue == FilterFavorites.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
                // ignore: avoid_print
                print(_showFavoriteOnly);
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductGrid(
          showFavoriteOnly: _showFavoriteOnly,
        ),
      ),
    );
  }
}
