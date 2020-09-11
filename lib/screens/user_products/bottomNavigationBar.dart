import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    Key key,
    @required this.currentIndex,
    @required this.onTap,
  }) : super(key: key);

  int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: theme.primaryColorLight,
      elevation: 5,
      selectedItemColor: theme.accentColor,
      selectedFontSize: 16,
      unselectedItemColor: theme.primaryColor,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.shifting,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shop_two),
          title: Text('Products'),
          backgroundColor: theme.primaryColorLight,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brush),
          title: Text('Editor'),
          backgroundColor: theme.primaryColorDark,
        ),
      ],
    );
  }
}
