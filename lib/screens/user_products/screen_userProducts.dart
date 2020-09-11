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
  var _editorProductId = '';

  Widget _buildSubscreens(int i) {
    if (i == 0) {
      return ProductsUserProducts(shiftTab: _shiftTab);
    } else {
      return EditorUserProducts(id: _editorProductId);
    }
  }

  void _shiftTab(int index, {String productId = ''}) {
    setState(() {
      _currentIndex = index;
      _editorProductId = productId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(ScreenUserProducts.label),
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
