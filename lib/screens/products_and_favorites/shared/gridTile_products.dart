// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_carts.dart';
import 'package:shop_app/providers/provider_products.dart';
import '../../../providers/model_product.dart';
// widget
import '../../../widgets/tappable_icon.dart';

// screens
import '../../product_detail/screen_productDetail.dart';

class ProductItemGridTile extends StatelessWidget {
  void _pushToDetailScreen({BuildContext context, String id}) {
    Navigator.of(context)
        .pushNamed(ScreenProductDetail.routeName, arguments: id);
  }

  void onTap(product, provider) {
    product.toggleFavoriteStatus();
    provider.toggleFavorite(product.id);
  }

  void onShoppingCartTap({
    @required ProviderCarts provider,
    @required String id,
    @required String title,
    @required double price,
  }) {
    provider.addItem(
      id: id,
      title: title,
      price: price,
    );
  }

  bool isInCart({@required ProviderCarts provider, @required String id}) {
    return provider.findById(id: id);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final providerProducts =
        Provider.of<ProviderProducts>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    // This listener (Provider.of()) make this widget rebuild any time its data
    // changes (think of a toggle isFavorite property).
    // By setting the listen to false, it gets data (that is not supposed to change
    // such as title, description) only one time;
    // but wrap favorite button with Consumer.
    // print('product_itemGridTile');

    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: () => _pushToDetailScreen(
        context: context,
        id: product.id,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        elevation: 5,
        child: GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          header: GridTileBar(
            trailing: CircleAvatar(
              backgroundColor: Colors.black26,
              child: Consumer<ProviderCarts>(
                builder: (BuildContext context, ProviderCarts providerCarts,
                        Widget widget) =>
                    TappableIcon(
                  condition: isInCart(
                    provider: providerCarts,
                    id: product.id,
                  ),
                  ifFalse: Icons.add_shopping_cart,
                  ifTrue: Icons.shopping_cart,
                  onPressed: () => onShoppingCartTap(
                    provider: providerCarts,
                    id: product.id,
                    title: product.title,
                    price: product.price,
                  ),
                  theme: theme,
                ),
              ),
            ),
          ),
          footer: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: const Radius.circular(15.0),
              bottomRight: const Radius.circular(15.0),
            ),
            child: GridTileBar(
              backgroundColor: Colors.black38,
              title: FittedBox(
                child: Text(
                  product.title,
                  textAlign: TextAlign.right,
                ),
              ),
              leading: Consumer<Product>(
                builder: (BuildContext context, Product product, Widget child) {
                  // here use context because it's supposed to react
                  // on changes of this product
                  return TappableIcon(
                    condition: product.isFavorite,
                    onPressed: () => onTap(product, providerProducts),
                    ifTrue: Icons.favorite,
                    ifFalse: Icons.favorite_border,
                    theme: theme,
                  );
                },
                child: Text(
                    'Here you can store Widget Three that you don\'t want to make rebuild when consumer rebuilds.'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
