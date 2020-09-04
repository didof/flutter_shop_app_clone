import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_order.dart';
import 'package:shop_app/providers/provider_orders.dart';

class ListViewOrders extends StatelessWidget {
  const ListViewOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderOrders>(context);

    return ListView.builder(
      itemCount: provider.amount,
      itemBuilder: (context, i) {
        return ListItemOrder(
          order: provider.data[i],
        );
      },
    );
  }
}

class ListItemOrder extends StatefulWidget {
  final Order order;
  ListItemOrder({
    @required this.order,
  });

  @override
  _ListItemOrderState createState() => _ListItemOrderState();
}

class _ListItemOrderState extends State<ListItemOrder> {
  var _expanded = false;

  void _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  IconData get icon {
    return _expanded ? Icons.expand_less : Icons.expand_more;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('€ ${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(icon),
              onPressed: _toggleExpansion,
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height:
                  min(widget.order.products.length.toDouble() * 20 + 100, 120),
              child: ListView.builder(
                itemBuilder: (context, i) {
                  final product = widget.order.products[i];
                  return ListTile(
                    title: Text('${product.quantity} X ${product.title}'),
                    trailing: Text('€ ${product.price * product.quantity}'),
                  );
                },
                itemCount: widget.order.products.length,
              ),
            )
        ],
      ),
    );
  }
}
