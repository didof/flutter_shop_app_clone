// flutter
import 'package:flutter/material.dart';

// provider
import 'package:provider/provider.dart';
import '../../providers/provider_products.dart';

import '../../models/model_product.dart';

class ScreenProductDetail extends StatelessWidget {
  static const routeName = '/products/detail';

  AppBar _buildAppBar(String id) {
    return AppBar(title: Text(id));
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final Product product = Provider.of<ProviderProducts>(
      context,
      listen: false, // do not listen to notifyListeners()
    ).findById(id);

    return Scaffold(
      appBar: _buildAppBar(product.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '€ ${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Text(
                product.description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
