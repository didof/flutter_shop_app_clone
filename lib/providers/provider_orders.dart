import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop_app/database/url.dart';
import 'package:shop_app/models/model_cart.dart';
import 'package:shop_app/models/model_http_exception.dart';
import 'package:shop_app/models/model_order.dart';

class ProviderOrders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get data {
    return [..._orders];
  }

  int get amount {
    return _orders.length;
  }

  Future<void> addOrder(List<Cart> cart, double amount) async {
    print('[ProviderOrders] addOrder called');
    final dateTime = DateTime.now();
    try {
      final response = await http.post(
        DatabaseUrl.url_orders,
        body: json.encode({
          'amount': amount,
          'dateTime': dateTime.toIso8601String(),
          'products': cart.map((p) {
            return {
              'id': p.id,
              'title': p.title,
              'price': p.price,
              'quantity': p.quantity,
            };
          }).toList(),
        }),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Could not send the order');
      }
      _orders.insert(
          0,
          Order(
            id: json.decode(response.body)['name'],
            dateTime: dateTime,
            products: cart,
            amount: amount,
          ));
    } catch (error) {
      print('[ProviderOrders] addOrder error $error');
    } finally {
      print('[ProviderOrders] addOrder finally');
      notifyListeners();
    }
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final response = await http.get(DatabaseUrl.url_orders);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      List<Order> loadedOrders = [];
      if (extracted == null) {
        _orders = [];
        return;
      }
      extracted.forEach((id, order) {
        loadedOrders.add(
          Order(
              id: id,
              amount: order['amount'],
              dateTime: DateTime.parse(order['dateTime']),
              products: (order['products'] as List<dynamic>).map((p) {
                return Cart(
                  id: p['id'],
                  title: p['title'],
                  price: p['price'],
                  quantity: p['quantity'],
                );
              }).toList()),
        );
      });
      _orders = loadedOrders;
    } catch (error) {
      print('[ProviderOrders] fetchAndSetOrders error $error');
    } finally {
      notifyListeners();
    }
  }
}
