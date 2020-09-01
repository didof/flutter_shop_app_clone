// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_products.dart';
import '../../../providers/model_product.dart';
// widget
import '../../../widgets/tappable/tappable_icon.dart';

// screens
import '../../productDetail/screen_productDetail.dart';

class ProductItemGridTile extends StatelessWidget {
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
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: theme.accentColor,
                ),
                onPressed: null,
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
                    onPressed: () => onTap(product, provider),
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
