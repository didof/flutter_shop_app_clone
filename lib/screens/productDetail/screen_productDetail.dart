// flutter
import 'package:flutter/material.dart';

// provider
import 'package:provider/provider.dart';
import '../../providers/provider_products.dart';

import '../../providers/model_product.dart';

class ScreenProductDetail extends StatelessWidget {
  static const routeName = '/products/detail';

  AppBar _buildAppBar(String id) {
    return AppBar(title: Text(id));
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final Product detail = Provider.of<ProviderProducts>(
      context,
      listen: false, // do not listen to notifyListeners()
    ).findById(id);

    return Scaffold(
        appBar: _buildAppBar(detail.title),
        body: Center(
          child: Text(detail.description),
        ));
  }
}
