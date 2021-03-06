import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/model_product.dart';
import 'package:shop_app/providers/provider_products.dart';

class EditorUserProducts extends StatefulWidget {
  final String id;
  final Function shiftTab;
  const EditorUserProducts({
    Key key,
    this.id,
    this.shiftTab,
  }) : super(key: key);

  @override
  _EditorUserProductsState createState() => _EditorUserProductsState();
}

class _EditorUserProductsState extends State<EditorUserProducts> {
  final _imageUrlController = TextEditingController();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageURL': '',
  };
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
  void didChangeDependencies() {
    print('didChangeDependencies first time: $_isInit');
    if (!_isInit || widget.id == 'empty') return;

    _editedProduct = Provider.of<ProviderProducts>(context).findById(widget.id);
    print('id: ${widget.id}');
    _initValues = {
      'title': _editedProduct.title,
      'price': _editedProduct.price.toString(),
      'description': _editedProduct.description,
      'imageUrl': '',
    };
    print(_initValues['title']);
    _imageUrlController.text = _editedProduct.imageUrl;
    _isInit = true;
    super.didChangeDependencies();
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

  void _buildDialog(BuildContext context) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        elevation: 5,
        title: Text('Something went wrong'),
        content: Text('try again later... :('),
        actions: [
          OutlineButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  String _pickAnImage() {
    const base = 'https://cdn.pixabay.com/photo/';
    const List<String> images = const [
      '2018/11/15/11/35/family-3817055_1280.jpg',
      '2016/11/14/03/43/asia-1822520_1280.jpg',
      '2018/01/11/09/52/blonde-3075756_1280.jpg',
      '2018/01/11/09/51/woman-3075743_1280.jpg',
      '2018/02/20/20/52/people-3168830_1280.jpg'
    ];
    final picked = base + images[Random().nextInt(images.length)];
    print(picked);
    return picked;
  }

  void _saveForm() async {
    print('[save form]:starting $_isLoading');
    setState(() {
      _isLoading = true;
    });

    final isNotValid = !_form.currentState.validate();
    if (isNotValid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _form.currentState.save();
    final provider = Provider.of<ProviderProducts>(context, listen: false);
    if (widget.id == 'empty') {
      try {
        await provider.addProduct(_editedProduct);
        widget.shiftTab(0);
      } catch (error) {
        _buildDialog(context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      try {
        await provider.updateProduct(widget.id, _editedProduct);
        widget.shiftTab(0);
      } catch (error) {
        _buildDialog(context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading
          ? Container(
              height: 500,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _form,
              autovalidate: true, // then you've got to call validator
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['title'],
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: widget.id != null ? widget.id : null,
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
                    initialValue: _initValues['price'],
                    decoration: InputDecoration(
                      labelText: 'Price',
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode),
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: widget.id != null ? widget.id : null,
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
                    initialValue: _initValues['description'],
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    focusNode: _descriptionFocusNode,
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: widget.id != null ? widget.id : null,
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
                                _imageUrlController.text = _pickAnImage();
                              },
                            ),
                          ),
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                              id: widget.id != null ? widget.id : null,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: newValue,
                            );
                          },
                          validator: (value) {
                            if (value.isEmpty) return 'imageUrl is required';
                            if (!value.startsWith('http') &&
                                !value.startsWith('https'))
                              return 'please enter a valid URL (start)';
                            if (!value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg') &&
                                !value.endsWith('.png'))
                              return 'please enter a valid URL (end)';
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

// TODO: refactoring
