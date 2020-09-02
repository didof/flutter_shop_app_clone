// flutter
import 'package:flutter/material.dart';
// provider
import 'package:shop_app/providers/provider_products.dart';
import 'package:provider/provider.dart';
import '../../../providers/model_product.dart';
// widget
import '../../../widgets/tappable_icon.dart';
// screens
import '../../product_detail/screen_productDetail.dart';

class ProductItemListTile extends StatelessWidget {
  void _pushToDetailScreen({BuildContext context, String id}) {
    Navigator.of(context)
        .pushNamed(ScreenProductDetail.routeName, arguments: id);
  }

  void onTap(product, provider) {
    product.toggleFavoriteStatus();
    provider.toggleFavorite(product.id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final provider = Provider.of<ProviderProducts>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);

    return Consumer<Product>(
      builder: (BuildContext context, Product product, Widget child) => InkWell(
        onTap: () => _pushToDetailScreen(
          context: context,
          id: product.id,
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                  product.title,
                  textAlign: TextAlign.left,
                ),
                leading: TappableIcon(
                  condition: product.isFavorite,
                  onPressed: () => onTap(product, provider),
                  ifTrue: Icons.favorite,
                  ifFalse: Icons.favorite_border,
                  theme: theme,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart, color: theme.accentColor),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
