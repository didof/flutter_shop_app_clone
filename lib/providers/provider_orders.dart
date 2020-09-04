import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/model_cart.dart';
import 'package:shop_app/models/model_order.dart';

class ProviderOrders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get data {
    return [..._orders];
  }

  int get amount {
    return _orders.length;
  }

  void addOrder(List<Cart> cart, double amount) {
    _orders.insert(
        0,
        Order(
          id: DateTime.now().toString(),
          dateTime: DateTime.now(),
          products: cart,
          amount: amount,
        ));
    notifyListeners();
  }
}
