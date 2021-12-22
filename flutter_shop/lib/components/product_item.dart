import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    //cortar de forma arrondada um determinado elemento
    //pode ser todos os lados ou apenas um que queira
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.productDetail,
                arguments: product);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
            iconSize: 20,
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              product.toggleFavorite();
            },
            icon: Icon(product.isFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined),
          ),
          trailing: IconButton(
            iconSize: 20,
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
