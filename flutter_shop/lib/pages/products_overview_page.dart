import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product_list_model.dart';
import '../components/app_drawer.dart';
import '../utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/badge.dart';
import '../components/product_grid.dart';
import '../models/cart_model.dart';

enum FilterFavorites { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false)
        .loadProduct()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        elevation: 0,
        centerTitle: true,
        actions: [
          //deixa a AppBar com um navbar pequeno
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
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
              setState(
                () {
                  if (selectedValue == FilterFavorites.favorite) {
                    _showFavoriteOnly = true;
                  } else {
                    _showFavoriteOnly = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ProductGrid(
                showFavoriteOnly: _showFavoriteOnly,
              ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
