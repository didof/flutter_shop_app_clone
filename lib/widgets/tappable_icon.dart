import 'package:flutter/material.dart';

class TappableIcon extends StatelessWidget {
  final bool condition;
  final Function onPressed;
  final IconData ifTrue;
  final IconData ifFalse;
  final ThemeData theme;
  TappableIcon({
    @required this.condition,
    @required this.onPressed,
    @required this.ifTrue,
    @required this.ifFalse,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // print('build tappable_icon');
    return IconButton(
      icon: Icon(
        condition ? ifTrue : ifFalse,
        color: theme != null ? theme.accentColor : Colors.red,
      ),
      onPressed: onPressed,
    );
  }
}
