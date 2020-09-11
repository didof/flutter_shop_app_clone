import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_products/subscreens/editor_userProducts.dart';
import 'package:shop_app/screens/user_products/subscreens/products_userProducts.dart';
import 'package:shop_app/screens/user_products/bottomNavigationBar.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/responsive_safe_area.dart';

class ScreenUserProducts extends StatefulWidget {
  const ScreenUserProducts({Key key}) : super(key: key);
  static const routeName = '/user_products';
  static const label = 'User Products';
  static const icon = Icons.person;

  @override
  _ScreenUserProductsState createState() => _ScreenUserProductsState();
}

class _ScreenUserProductsState extends State<ScreenUserProducts> {
  var _currentIndex = 0;

  Widget _buildSubscreens(int i) {
    if (i == 0) {
      return ProductsUserProducts();
    } else {
      return EditorUserProducts();
    }
  }

  // List<Widget> _buildActions(int i) {
  //   if (i == 0) {
  //     return null;
  //   } else {
  //     return [
  //       IconButton(icon: Icon(Icons.add), onPressed: _saveForm),
  //     ];
  //   }
  // }

  void _shiftTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(ScreenUserProducts.label),
          // actions: _buildActions(_currentIndex),
        ),
        drawer: CustomDrawer(),
        drawerScrimColor: Theme.of(context).primaryColor.withOpacity(0.1),
        body: ResponsiveSafeArea(
          hasPadding: true,
          builder: (context, size) {
            return _buildSubscreens(_currentIndex);
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _shiftTab,
        ),
      ),
    );
  }
}
