//flutter
import 'package:flutter/material.dart';
// provider
import 'package:provider/provider.dart';
import './providers/provider_products.dart';
import './providers/provider_UI.dart';
// screens
import './screens/productDetail/screen_productDetail.dart';
// import './screens/productsOverview/screen_productsOverview.dart';
import 'screens/products_and_favorites/screen_productsAndFavorites.dart';

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
      ],
      child: MaterialApp(
        title: 'Shop App',
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
          // ScreenProductsOverview.routeName: (_) => ScreenProductsOverview(),
          ScreenProductDetail.routeName: (_) => ScreenProductDetail(),
        },
      ),
    );
  }
}
