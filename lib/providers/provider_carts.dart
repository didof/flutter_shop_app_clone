import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class ProviderCarts with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {...items};
  }

  List<CartItem> get itemsList {
    return _items.values
        .map((e) => CartItem(
              id: e.id,
              price: e.price,
              quantity: e.quantity,
              title: e.title,
            ))
        .toList();
  }

  List<String> get itemsIds {
    return _items.keys.toList();
  }

  int get itemCount {
    return _items.length;
  }

  int get itemCountLiteral {
    var total = 0;
    _items.forEach((String id, CartItem cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((String key, CartItem value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem({
    @required String id,
    @required String title,
    @required double price,
  }) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (CartItem oldItem) => CartItem(
          id: oldItem.id,
          title: oldItem.title,
          price: oldItem.price,
          quantity: oldItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem({@required id}) {
    _items.remove(id);
    notifyListeners();
  }

  bool findById({@required String id}) {
    return _items.containsKey(id);
  }
}
