import 'package:flutter/material.dart';

class ProviderUI with ChangeNotifier {
  bool _isGridView = true;

  bool get isGridView {
    return _isGridView ? true : false;
  }

  void setGridView() {
    _isGridView = true;
    notifyListeners();
  }

  void setListView() {
    _isGridView = false;
    notifyListeners();
  }
}
