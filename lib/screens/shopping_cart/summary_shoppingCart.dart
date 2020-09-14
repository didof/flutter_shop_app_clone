// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_cart.dart';
import 'package:shop_app/providers/provider_orders.dart';
import 'package:shop_app/screens/orders/screen_orders.dart';
import '../../providers/provider_carts.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

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
            child: OrderButton(
              providerCarts: providerCarts,
              totalAmount: totalAmount,
              items: items,
              textStyle: textStyle,
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.providerCarts,
    @required this.totalAmount,
    @required this.items,
    @required this.textStyle,
  }) : super(key: key);

  final ProviderCarts providerCarts;
  final double totalAmount;
  final List<Cart> items;
  final TextStyle textStyle;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  void _confirmOrder({
    @required List<Cart> cartContent,
    @required double amount,
  }) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<ProviderOrders>(
      context,
      listen: false,
    ).addOrder(cartContent, amount);
    Provider.of<ProviderCarts>(
      context,
      listen: false,
    ).clear();
    setState(() {
      _isLoading = false;
    });
    Scaffold.of(context).showSnackBar(_buildSnackbar());
  }

  _buildSnackbar() {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.send),
          Text('Your order was sent.', style: TextStyle(color: Colors.white)),
        ],
      ),
      elevation: 5,
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'See',
          onPressed: () {
            Navigator.of(context).popAndPushNamed(ScreenOrders.routeName);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading)
      return LinearProgressIndicator();
    else
      return Builder(
        builder: (BuildContext context) => RaisedButton.icon(
          padding: const EdgeInsets.all(10.0),
          onPressed: widget.providerCarts.itemCount < 1
              ? null
              : () => _confirmOrder(
                    cartContent: widget.items,
                    amount: widget.totalAmount,
                  ),
          icon: Icon(
            Icons.beenhere,
            color: Colors.white,
          ),
          label: Text('Order', style: widget.textStyle),
          color: theme.primaryColor,
          splashColor: theme.accentColor,
        ),
      );
  }
}
