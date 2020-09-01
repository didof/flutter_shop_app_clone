// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_and_favorites/shared/listView_products.dart';
import '../../../providers/provider_UI.dart';
// views
import '../shared/gridView_products.dart';

class ScreenProductsOverview extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    final isGridView = Provider.of<ProviderUI>(
      context,
      listen: true,
    ).isGridView;

    return isGridView ? GridViewProducts() : ListViewProducts();
  }
}
