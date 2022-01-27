import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({
    Key? key,
  }) : super(key: key);

  final formatacaoReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formatacaoReal.format(product.price),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(product.description, textAlign: TextAlign.center),
              ),
            ],
          ),
        ));
  }
}
