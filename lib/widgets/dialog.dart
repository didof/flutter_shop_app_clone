import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/provider_UI.dart';

class DialogRemoveItem extends StatefulWidget {
  DialogRemoveItem({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _DialogRemoveItemState createState() => _DialogRemoveItemState();
}

class _DialogRemoveItemState extends State<DialogRemoveItem> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderUI>(context);

    return AlertDialog(
      title: Text('Are you sure?'),
      content: Text('Do you want to remove ${widget.title} from the cart?'),
      actions: [
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        OutlineButton(
          child: Text('Proceed'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
