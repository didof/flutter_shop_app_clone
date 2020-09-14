// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_UI.dart';
import 'package:shop_app/providers/provider_products.dart';
import 'package:shop_app/screens/products_and_favorites/shared/gridView_products.dart';
import 'package:shop_app/screens/products_and_favorites/shared/listView_products.dart';
// views

class ScreenProductsOverview extends StatefulWidget {
  static const routeName = '/products';

  @override
  _ScreenProductsOverviewState createState() => _ScreenProductsOverviewState();
}

class _ScreenProductsOverviewState extends State<ScreenProductsOverview> {
  @override
  void initState() {
    // method 1
    // Provider.of<ProviderProducts>(context, listen: false).fetchAndSetProducts();
    // since at time of initState this widget isn't still fully wired up,
    // context will give an error; but setting listen on false will work.

    // method 2
    // Future.delayed(Duration.zero).then((_) {
    //   return Provider.of<ProviderProducts>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  // method 3
  // var _isInit = true;
  // @override
  // void didChangeDependencies() {
  //   if (!_isInit) return;
  //   Provider.of<ProviderProducts>(context).fetchAndSetProducts();

  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final isGridView = Provider.of<ProviderUI>(
      context,
      listen: true,
    ).isGridView;

    return isGridView ? GridViewProducts() : ListViewProducts();
  }
}
