import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_app/models/model_product.dart';

class EditorUserProducts extends StatefulWidget {
  const EditorUserProducts({Key key}) : super(key: key);

  @override
  _EditorUserProductsState createState() => _EditorUserProductsState();
}

class _EditorUserProductsState extends State<EditorUserProducts> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  static const _spacer = SizedBox(
    height: 30,
    width: 30,
  );

  void _saveForm() {
    final isNotValid = !_form.currentState.validate();
    if (isNotValid) return;
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        autovalidate: true, // then you've got to call validator
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
              onSaved: (newValue) {
                _editedProduct = Product(
                  id: null,
                  title: newValue,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                );
              },
              validator: (value) {
                if (value.isEmpty) return 'Title is required';
                return null;
              },
            ),
            _spacer,
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
              onSaved: (newValue) {
                _editedProduct = Product(
                  id: null,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: double.parse(newValue),
                  imageUrl: _editedProduct.imageUrl,
                );
              },
              validator: (value) {
                if (value.isEmpty) return 'Price is required';
                if (double.tryParse(value) == null)
                  return 'Please choose a valid number';
                if (double.parse(value) <= 0)
                  return 'Please choose a positive number';
                return null;
              },
            ),
            _spacer,
            TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              focusNode: _descriptionFocusNode,
              onSaved: (newValue) {
                _editedProduct = Product(
                  id: null,
                  title: _editedProduct.title,
                  description: newValue,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                );
              },
              validator: (value) {
                if (value.isEmpty) return 'Description is required';
                if (value.length < 10)
                  return 'Description has to be at least 10 characters long';
                return null;
              },
            ),
            _spacer,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(0.1),
                        Colors.grey.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? null
                      : FittedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                _spacer,
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      print('onFieldSubmitted');
                      _saveForm();
                    },
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          _imageUrlController.clear();
                          setState(() {});
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          _imageUrlController.text =
                              'https://cdn.pixabay.com/photo/2018/11/15/11/35/family-3817055_1280.jpg';
                        },
                      ),
                    ),
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: null,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: newValue,
                      );
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'imageUrl is required';
                      if (!value.startsWith('http') ||
                          !value.startsWith('https'))
                        return 'please enter a valid URL';
                      if (!value.endsWith('.jpg') ||
                          !value.endsWith('.jpeg') ||
                          !value.endsWith('.png'))
                        return 'please enter a valid URL';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            _spacer,
            SizedBox(
              width: double.infinity,
              child: FlatButton.icon(
                onPressed: _saveForm,
                icon: Icon(Icons.check),
                label: Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
