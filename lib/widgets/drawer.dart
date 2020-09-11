import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders/screen_orders.dart';
import 'package:shop_app/screens/products_and_favorites/screen_productsAndFavorites.dart';
import 'package:shop_app/screens/shopping_cart/screen_shoppingCart.dart';
import 'package:shop_app/screens/user_products/screen_userProducts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  Widget _buildListTile({
    BuildContext context,
    IconData icon,
    String label,
    String routeName,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.of(context).popAndPushNamed(routeName);
      },
    );
  }

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Pages'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          _buildListTile(
            context: context,
            routeName: ScreenProductsAndFavorites.routeName,
            icon: ScreenProductsAndFavorites.icon,
            label: ScreenProductsAndFavorites.label,
          ),
          _buildListTile(
            context: context,
            routeName: ScreenShoppingCart.routeName,
            icon: ScreenShoppingCart.icon,
            label: ScreenShoppingCart.label,
          ),
          _buildListTile(
            context: context,
            routeName: ScreenOrders.routeName,
            icon: ScreenOrders.icon,
            label: ScreenOrders.label,
          ),
          _buildListTile(
            context: context,
            routeName: ScreenUserProducts.routeName,
            icon: ScreenUserProducts.icon,
            label: ScreenUserProducts.label,
          ),
        ],
      ),
    );
  }
}
