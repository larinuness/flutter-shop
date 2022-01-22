import 'package:flutter/material.dart';
import '../models/product_list_model.dart';
import '../utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.productsForm,
                      arguments: product);
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  //vai parecer um dialog pra confirmar se vai excluir ou não
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Tem certeza?'),
                      content: const Text('Deseja remover o item do carrinho?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<ProductList>(context, listen: false)
                                .removeProduct(product);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor)),
          ],
        ),
      ),
    );
  }
}
