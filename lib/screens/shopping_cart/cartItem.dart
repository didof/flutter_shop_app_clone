import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_UI.dart';
import 'package:shop_app/providers/provider_carts.dart';
import 'package:shop_app/widgets/dialog.dart';

class CartItem extends StatefulWidget {
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
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var _expanded = false;

  IconData get icon {
    return _expanded ? Icons.expand_less : Icons.expand_more;
  }

  void updateQuantity({
    @required bool increment,
    @required ProviderCarts provider,
  }) {
    if (increment) {
      provider.addOneItem(id: widget.productId);
    } else {
      if (widget.quantity > 1) {
        provider.removeOneItem(id: widget.productId);
      } else {
        provider.removeItem(id: widget.id);
      }
    }
  }

  SnackBar _buildSnackbar({String title}) {
    return SnackBar(
      duration: Duration(seconds: 3),
      elevation: 5,
      content: Text(
          '${title != null ? title : 'the item'} was removed from the cart'),
    );
  }

  void removeItem(
      {@required ProviderCarts provider, @required BuildContext context}) {
    provider.removeItem(id: widget.productId);
    Scaffold.of(context).showSnackBar(_buildSnackbar(title: widget.title));
  }

  Future<bool> pushDialog({@required context, @required title}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogRemoveItem(
          title: title,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<ProviderCarts>(context);

    return Dismissible(
      key: Key(widget.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) =>
          removeItem(provider: provider, context: context),
      confirmDismiss: (direction) => pushDialog(
        context: context,
        title: widget.title,
      ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: theme.primaryColor,
                    child: FittedBox(child: Text('\€ ${widget.price}')),
                  ),
                ),
                title: Text('${widget.quantity} X ${widget.title}'),
                subtitle: Text('Total: \€ ${widget.price * widget.quantity}'),
                trailing: IconButton(
                  icon: Icon(icon),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Quantity:'),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          onPressed: () => updateQuantity(
                            provider: provider,
                            increment: true,
                          ),
                        ),
                        Text(widget.quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () => updateQuantity(
                            provider: provider,
                            increment: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
