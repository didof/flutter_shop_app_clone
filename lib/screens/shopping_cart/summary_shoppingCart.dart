// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../providers/provider_carts.dart';

class Summary extends StatelessWidget {
  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    final totalAmount = Provider.of<ProviderCarts>(context).totalAmount;
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
                backgroundColor: theme.primaryColor,
                elevation: 5,
                avatar: CircleAvatar(
                  child: Text('€', style: textStyle),
                  backgroundColor: theme.accentColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: RaisedButton.icon(
              padding: const EdgeInsets.all(10.0),
              onPressed: () {},
              icon: Icon(
                Icons.beenhere,
                color: Colors.white,
              ),
              label: Text('Order', style: textStyle),
              color: theme.primaryColor,
              splashColor: theme.accentColor,
            ),
          )
        ],
      ),
    );
  }
}
