class DatabaseUrl {
  static const url_base = "https://flutter-shop-app-d836a.firebaseio.com/";
  static const ext = '.json';
  static const url_products = url_base + "products" + ext;

  final String id;
  DatabaseUrl({this.id});

  String get productPath {
    return url_base + "products/" + id + ext;
  }
}
