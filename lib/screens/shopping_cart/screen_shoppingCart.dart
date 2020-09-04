// flutter
import 'package:flutter/material.dart';
// widgets
import 'summary_shoppingCart.dart';
import './listViewCartItems_shoppingCart.dart';

class ScreenShoppingCart extends StatelessWidget {
  static const routeName = '/cart';
  static const label = 'Cart';
  static const icon = Icons.shopping_cart;

  Widget _buildCard({@required Widget child, @required double height}) {
    return Container(
      height: height,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Column(
          children: <Widget>[
            _buildCard(
              child: ListViewCartItems(),
              height: constraints.maxHeight * 0.7,
            ),
            _buildCard(
              child: Summary(),
              height: constraints.maxHeight * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
