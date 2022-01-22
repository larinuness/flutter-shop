import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_item_widget.dart';
import '../models/cart_model.dart';
import '../models/order_list_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //Widget que serve pra valores, deixa mais bonito
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                        'R\$ ${cart.totalCart.toStringAsFixed(2)}'
                            .replaceAll('.', ','),
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color)),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      //add os items(produtos) no pedido
                      Provider.of<OrderList>(context, listen: false)
                          .addOrder(cart);
                      //limpa carrinho
                      cart.clear();
                    },
                    child:
                        const Text('Comprar', style: TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            //passa os produtos(item)
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CarItemWidget(cartItem: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
