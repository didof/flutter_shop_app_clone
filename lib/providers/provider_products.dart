// flutter
import 'package:flutter/material.dart';
import 'package:shop_app/models/model_http_exception.dart';
import 'dart:convert';
// model
import '../models/model_product.dart';
// data
// import '../assets/data/data_products.dart';
import 'package:shop_app/database/url.dart';
// external
import 'package:http/http.dart' as http;

class ProviderProducts with ChangeNotifier {
  List<Product> _products = [];
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

  Future<void> updateProduct(String id, Product updatedProduct) async {
    print('[ProviderProducts] updateProduct called');
    try {
      final response = await http.patch(
        DatabaseUrl(id: id).productPath,
        body: json.encode({
          'title': updatedProduct.title,
          'description': updatedProduct.description,
          'imageUrl': updatedProduct.imageUrl,
          'price': updatedProduct.price,
        }),
      );
      print(response.body);
      final index = _products.indexWhere((p) => p.id == id);
      _products[index] = updatedProduct;
      notifyListeners();
    } catch (error) {
      print('[ProviderProducts] updateProduct error');
    } finally {
      print('[ProviderProducts] updateProduct ended');
    }
  }

  Future<void> removeProduct(String id) async {
    print('[ProviderProducts] removeProduct called');
    final existingProductIndex = _products.indexWhere((p) => p.id == id);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    notifyListeners();
    try {
      final response = await http.delete(DatabaseUrl(id: id).productPath);
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product');
      }
      existingProduct = null;
    } catch (error) {
      print('[ProviderProducts] removeProduct reset');
      _products.insert(existingProductIndex, existingProduct);
      notifyListeners();
    } finally {
      print('[ProviderProducts] removeProduct ended');
    }
  }

  Future<void> fetchAndSetProducts() async {
    print('[ProviderProducts] fetchAndSetProducts called');
    try {
      final response = await http.get(DatabaseUrl.url_products);
      final body = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      body.forEach((id, data) {
        loadedProducts.add(
          Product(
              id: id,
              title: data['title'],
              description: data['description'],
              imageUrl: data['imageUrl'],
              price: data['price'],
              isFavorite: data['isFavorite']),
        );
      });
      _products = loadedProducts;
      print(_products);
      notifyListeners();
    } catch (error) {
      print('[ProviderProducts] fetchAndSetProducts error -> $error');
      throw error;
    } finally {
      print('[ProviderProducts] fetchAndSetProducts ended');
    }
  }
}
