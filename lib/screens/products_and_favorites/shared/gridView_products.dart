// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../../providers/provider_products.dart';
import '../../../providers/model_product.dart';
// widget
import 'gridTile_products.dart';

class GridViewProducts extends StatelessWidget {
  final bool onlyFavorite;
  GridViewProducts({this.onlyFavorite = false});

  static const sliverGridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 2 / 3,
    crossAxisSpacing: 18,
    mainAxisSpacing: 14,
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderProducts>(context);
    final List<Product> products =
        onlyFavorite ? provider.favoriteProducts : provider.allProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: products.length,
      gridDelegate: sliverGridDelegate,
      itemBuilder: (BuildContext ctx, int i) => ChangeNotifierProvider.value(
        value: products[i], // instance of Product()
        child: ProductItemGridTile(),
      ),
    );
  }
}
