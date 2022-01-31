import 'package:flutter/material.dart';
import '../components/order_item.dart';
import '../models/order_list_model.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro'),
            );
          } else {
            return Consumer<OrderList>(builder: (context, orders, child) {
              return ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (context, index) {
                    return OrderItem(
                      order: orders.items[index],
                    );
                  });
            });
          }
        },
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
      ),
    );
  }
}
