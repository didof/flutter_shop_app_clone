import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FAB extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  bool isVisible;
  FAB({
    @required this.onPressed,
    @required this.icon,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: FloatingActionButton(
        onPressed: onPressed,
        child: icon,
      ),
      visible: isVisible,
    );
    ;
  }
}
