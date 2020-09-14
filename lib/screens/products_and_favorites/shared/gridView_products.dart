// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import '../../../providers/provider_products.dart';
import '../../../models/model_product.dart';
// widget
import 'gridTile_products.dart';

class GridViewProducts extends StatefulWidget {
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
  _GridViewProductsState createState() => _GridViewProductsState();
}

class _GridViewProductsState extends State<GridViewProducts> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (!_isInit) return;
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProviderProducts>(context).fetchAndSetProducts();
    setState(() {
      _isLoading = false;
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProviderProducts>(context, listen: false)
        .fetchAndSetProducts();
    // set listen to false because I want to refresh only when user pull
    // the RefreshIndicator
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderProducts>(context);
    final List<Product> products =
        widget.onlyFavorite ? provider.favoriteProducts : provider.allProducts;

    return !_isLoading
        ? RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: products.length,
              gridDelegate: GridViewProducts.sliverGridDelegate,
              itemBuilder: (BuildContext ctx, int i) =>
                  ChangeNotifierProvider.value(
                value: products[i], // instance of Product()
                child: ProductItemGridTile(),
              ),
            ),
          )
        : Column(
            children: [
              Text('I\'m searching products . . .'),
              Center(child: CircularProgressIndicator()),
            ],
          );
  }
}
