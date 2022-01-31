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
                  CartButton(cart: cart)
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

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    //add os items(produtos) no pedido
                    await Provider.of<OrderList>(context, listen: false)
                        .addOrder(widget.cart);
                    //limpa carrinho
                    setState(() {
                      _isLoading = false;
                    });
                    widget.cart.clear();
                  },
            child: const Text(
              'Comprar',
              style: TextStyle(fontSize: 17),
            ),
          );
  }
}
