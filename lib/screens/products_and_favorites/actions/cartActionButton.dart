// flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/screens/shopping_cart/screen_shoppingCart.dart';
import '../../../providers/provider_carts.dart';
// widget
import '../../../widgets/badge.dart';

class CartActionButton extends StatelessWidget {
  void _navigateToShoppingCartScreen({@required BuildContext context}) {
    Navigator.of(context).pushNamed(ScreenShoppingCart.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCarts>(
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () => _navigateToShoppingCartScreen(context: context),
      ),
      builder: (
        BuildContext context,
        ProviderCarts providerCarts,
        Widget stableChild,
      ) =>
          Badge(
        child: stableChild,
        value: providerCarts.itemCountLiteral.toString(),
      ),
    );
  }
}
