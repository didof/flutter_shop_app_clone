import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/model_cart.dart';

class ProviderCarts with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {...items};
  }

  List<Cart> get itemsList {
    return _items.values
        .map((e) => Cart(
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
    _items.forEach((String id, Cart cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((String key, Cart value) {
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
        (Cart oldItem) => Cart(
          id: oldItem.id,
          title: oldItem.title,
          price: oldItem.price,
          quantity: oldItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => Cart(
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

  void removeOneItem({@required id}) {
    _items.update(id, (oldCart) {
      return Cart(
        id: id,
        price: oldCart.price,
        title: oldCart.title,
        quantity: oldCart.quantity - 1,
      );
    });
    notifyListeners();
  }

  void addOneItem({@required id}) {
    _items.update(id, (oldCart) {
      return Cart(
        id: id,
        price: oldCart.price,
        title: oldCart.title,
        quantity: oldCart.quantity + 1,
      );
    });
    notifyListeners();
  }

  bool findById({@required String id}) {
    return _items.containsKey(id);
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
