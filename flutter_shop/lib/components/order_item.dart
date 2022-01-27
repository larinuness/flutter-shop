import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'package:intl/intl.dart';

//stateful pra expander os detalhes
class OrderItem extends StatefulWidget {
  final Order order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
                'R\$ ${widget.order.total.toStringAsFixed(2).replaceAll('.', ',')}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: const Icon(Icons.expand_more),
            ),
          ),
          //só mostra os detalhes se tiver true
          if (_expanded == true)
            Container(
              height: (widget.order.products.length * 25) + 10,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                //converte cada product em um elemento visual
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product.quantity} x R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
