// flutter
import 'package:flutter/material.dart';
// model
import 'model_product.dart';
// data
import '../assets/data/data_products.dart';

class ProviderProducts with ChangeNotifier {
  List<Product> _products = databaseProducts;
  List<Product> _favoriteProducts = [];

  List<Product> get allProducts {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return [..._favoriteProducts];
  }

  Product findById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }

  void toggleFavorite(String id) {
    final product =
        _favoriteProducts.firstWhere((p) => p.id == id, orElse: () => null);
    if (product == null) _favoriteProducts.add(findById(id));
    if (product != null) _favoriteProducts.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void addProduct(value) {
    // _items.add(value);
    notifyListeners();
  }
}
