//flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_orders.dart';
import 'package:shop_app/screens/orders/screen_orders.dart';
import 'package:shop_app/screens/user_products/screen_userProducts.dart';
import './providers/provider_products.dart';
import './providers/provider_UI.dart';
import 'providers/provider_carts.dart';
// screens
import 'screens/product_detail/screen_productDetail.dart';
import 'screens/products_and_favorites/screen_productsAndFavorites.dart';
import 'screens/shopping_cart/screen_shoppingCart.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderProducts()),
        ChangeNotifierProvider(create: (_) => ProviderUI()),
        ChangeNotifierProvider(create: (_) => ProviderCarts()),
        ChangeNotifierProvider(create: (_) => ProviderOrders()),
      ],
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          ScreenProductsAndFavorites.routeName: (_) =>
              ScreenProductsAndFavorites(),
          ScreenProductDetail.routeName: (_) => ScreenProductDetail(),
          ScreenShoppingCart.routeName: (_) => ScreenShoppingCart(),
          ScreenOrders.routeName: (_) => ScreenOrders(),
          ScreenUserProducts.routeName: (_) => ScreenUserProducts(),
        },
      ),
    );
  }
}
