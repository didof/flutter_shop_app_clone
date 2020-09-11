import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_products.dart';
import 'package:shop_app/screens/product_detail/screen_productDetail.dart';

class ProductsUserProducts extends StatefulWidget {
  const ProductsUserProducts({Key key}) : super(key: key);

  @override
  _ProductsUserProductsState createState() => _ProductsUserProductsState();
}

class _ProductsUserProductsState extends State<ProductsUserProducts> {
  int _selectedTile;

  void _selectTile(int i) {
    setState(() {
      _selectedTile = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProviderProducts>(
      context,
      listen: true,
    );
    return ListView.separated(
      itemCount: productsProvider.allProducts.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int i) {
        final product = productsProvider.allProducts[i];
        final listItem = ListItem(
          id: product.id,
          title: product.title,
          imageUrl: product.imageUrl,
          selected: _selectedTile == i ? true : false,
          index: i,
          onTap: _selectTile,
        );
        if (i == 0) {
          return Container(
              height: 80, child: Column(children: [Spacer(), listItem]));
        } else
          return listItem;
      },
    );
  }
}

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function onTap;
  final int index;
  bool selected;

  ListItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.selected,
    @required this.onTap,
    @required this.index,
  }) : super(key: key);

  void navigateToDetailScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ScreenProductDetail.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      color: selected ? theme.primaryColorLight : Colors.transparent,
      child: ListTile(
        enabled: true,
        selected: selected,
        onTap: () => onTap(index),
        onLongPress: () => navigateToDetailScreen(context),
        title: Text(title, style: selected ? TextStyle(fontSize: 20) : null),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: selected
            ? Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                      color: theme.primaryColor,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                      color: theme.errorColor,
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
