// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../../providers/provider_products.dart';
import '../../../models/model_product.dart';
// widget
import 'listTile_products.dart';

class ListViewProducts extends StatelessWidget {
  final bool onlyFavorite;
  ListViewProducts({this.onlyFavorite = false});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderProducts>(context);
    final List<Product> products =
        onlyFavorite ? provider.favoriteProducts : provider.allProducts;

    return Container(
      height: 600,
      child: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, int i) => ChangeNotifierProvider.value(
          value: products[i], // instance of Product()
          child: ProductItemListTile(),
        ),
      ),
    );
  }
}
