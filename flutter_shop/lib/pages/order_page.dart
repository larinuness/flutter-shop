import 'package:flutter/material.dart';
import 'package:flutter_shop/components/order_item.dart';
import 'package:flutter_shop/models/order_list_model.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (context, index) {
            return OrderItem(
              order: orders.items[index],
            );
          }),
    );
  }
}
