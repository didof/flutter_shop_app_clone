// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_cart.dart';
import 'package:shop_app/providers/provider_orders.dart';
import 'package:shop_app/screens/orders/screen_orders.dart';
import '../../providers/provider_carts.dart';

class Summary extends StatelessWidget {
  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  _buildSnackbar({BuildContext context, ThemeData theme}) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.send),
          Text('Your order was sent.', style: TextStyle(color: Colors.white)),
        ],
      ),
      elevation: 5,
      backgroundColor: theme.primaryColor,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'See',
          onPressed: () {
            Navigator.of(context).popAndPushNamed(ScreenOrders.routeName);
          }),
    );
  }

  void _confirmOrder({
    @required BuildContext context,
    @required List<Cart> cartContent,
    @required double amount,
    @required ThemeData theme,
  }) {
    Provider.of<ProviderOrders>(
      context,
      listen: false,
    ).addOrder(cartContent, amount);
    Provider.of<ProviderCarts>(
      context,
      listen: false,
    ).clear();

    Scaffold.of(context)
        .showSnackBar(_buildSnackbar(context: context, theme: theme));
  }

  dynamic _enableButton({condition, context, cartContent, amount, theme}) {
    if (condition) {
      return () => _confirmOrder(
            context: context,
            cartContent: cartContent,
            amount: amount,
            theme: theme,
          );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerCarts = Provider.of<ProviderCarts>(context);
    final totalAmount = providerCarts.totalAmount;
    final items = providerCarts.itemsList;
    final theme = Theme.of(context);

    return Container(
      height: 120,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Total', style: TextStyle(fontSize: 20)),
              Chip(
                label: Text(totalAmount.toStringAsFixed(2), style: textStyle),
                backgroundColor:
                    totalAmount > 0 ? theme.primaryColor : theme.disabledColor,
                elevation: 5,
                avatar: CircleAvatar(
                  child: Text('€', style: textStyle),
                  backgroundColor:
                      totalAmount > 0 ? theme.accentColor : theme.dividerColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) => RaisedButton.icon(
                padding: const EdgeInsets.all(10.0),
                onPressed: _enableButton(
                  condition: providerCarts.itemCount >= 1,
                  amount: totalAmount,
                  cartContent: items,
                  context: context,
                  theme: theme,
                ),
                icon: Icon(
                  Icons.beenhere,
                  color: Colors.white,
                ),
                label: Text('Order', style: textStyle),
                color: theme.primaryColor,
                splashColor: theme.accentColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
