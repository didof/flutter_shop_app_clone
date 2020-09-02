// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../providers/provider_carts.dart' show ProviderCarts;

class ListViewCartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarts>(context, listen: false);
    final items = provider.itemsList;
    final keys = provider.itemsIds;

    return ListView.builder(
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
    );
  }
}

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<ProviderCarts>(context);

    void removeItem({@required id}) {
      provider.removeItem(id: id);
    }

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => removeItem(id: productId),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: theme.errorColor,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.all(10.0),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: theme.primaryColor,
                child: FittedBox(child: Text('\€ $price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \€ ${price * quantity}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
