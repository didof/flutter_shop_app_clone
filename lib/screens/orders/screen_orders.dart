import 'package:flutter/material.dart';
import 'package:shop_app/widgets/drawer.dart' show CustomDrawer;

import 'listView_orders.dart';

class ScreenOrders extends StatelessWidget {
  const ScreenOrders({Key key}) : super(key: key);
  static const routeName = '/orders';
  static const label = 'Orders';
  static const icon = Icons.payment;

  Widget _buildCard({@required Widget child, @required double height}) {
    return Container(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  double _fraction(BoxConstraints c, int fraction) {
    return c.maxHeight * (fraction / 10);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            _buildCard(
              height: _fraction(constraints, 10),
              child: ListViewOrders(),
            )
          ],
        );
      }),
      drawer: CustomDrawer(),
    );
  }
}