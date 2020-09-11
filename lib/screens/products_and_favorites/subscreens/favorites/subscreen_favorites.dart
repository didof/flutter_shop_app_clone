// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_UI.dart';
import 'package:shop_app/screens/products_and_favorites/shared/gridView_products.dart';
import 'package:shop_app/screens/products_and_favorites/shared/listView_products.dart';
import '../../../providers/provider_UI.dart';
// views
import '../shared/gridView_products.dart';
import '../shared/listView_products.dart';

class ScreenFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isGridView = Provider.of<ProviderUI>(
      context,
      listen: true,
    ).isGridView;

    return isGridView
        ? GridViewProducts(
            onlyFavorite: true,
          )
        : ListViewProducts(
            onlyFavorite: true,
          );
  }
}
