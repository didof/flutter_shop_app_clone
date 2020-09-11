// flutter
import 'package:flutter/material.dart';
// model
import '../models/model_product.dart';
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

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _products.add(newProduct);
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index < 0)
      throw AssertionError('[updateProduct] received negative index');
    _products[index] = updatedProduct;
    notifyListeners();
  }
}
