// flutter
import 'package:flutter/material.dart';
import 'dart:convert';
// model
import '../models/model_product.dart';
// data
import '../assets/data/data_products.dart';
import 'package:shop_app/database/url.dart';
// external
import 'package:http/http.dart' as http;

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

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        DatabaseUrl.url_products,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _products.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index < 0)
      throw AssertionError('[updateProduct] received negative index');
    _products[index] = updatedProduct;
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
