import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/database/url.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    print('[Product] toggleFavorite Status called');
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(
        DatabaseUrl(id: id).productPath,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
      }
    } catch (error) {
      print('[Product] toggleFavorite Status error: $error');
      isFavorite = !isFavorite;
    } finally {
      notifyListeners();
    }
  }
}
