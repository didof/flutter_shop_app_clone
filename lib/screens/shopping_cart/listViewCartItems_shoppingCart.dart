// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../providers/provider_carts.dart' show ProviderCarts;
// widget
import 'cartItem.dart';

class ListViewCartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarts>(context, listen: true);
    final items = provider.itemsList;
    final keys = provider.itemsIds;

    return provider.itemCount > 0
        ? ListView.builder(
            itemCount: provider.itemCount,
            itemBuilder: (BuildContext context, int i) {
              return CartItem(
                id: items[i].id,
                productId: keys[i],
                price: items[i].price,
                quantity: items[i].quantity,
                title: items[i].title,
              );
            },
          )
        : Center(
            child: Text(
              'Cart is empty',
              style: TextStyle(fontSize: 30),
            ),
          );
  }
}
