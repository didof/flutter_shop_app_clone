// flutter
import 'package:flutter/material.dart';
// sub screens
import 'productsOverview/subscreen_productsOverview.dart';
import 'favorites/subscreen_favorites.dart';
// appBar actions
import 'actions/popupMenuButton.dart';
import 'actions/cartActionButton.dart';

class ScreenProductsAndFavorites extends StatefulWidget {
  static const routeName = '/';

  @override
  _ScreenProductsAndFavoritesState createState() =>
      _ScreenProductsAndFavoritesState();
}

class _ScreenProductsAndFavoritesState
    extends State<ScreenProductsAndFavorites> {
  int _initialIndex = 0;
  String _appBarTitle;

  void _updateAppBarTitle(int index) {
    setState(() {
      _appBarTitle = choices[index].title;
    });
  }

  @override
  void initState() {
    _appBarTitle = choices[_initialIndex].title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      initialIndex: _initialIndex,
      length: choices.length,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_appBarTitle),
              elevation: 5,
              bottom: TabBar(
                onTap: _updateAppBarTitle,
                indicatorWeight: 3.0,
                indicatorColor: theme.accentColor,
                isScrollable: true,
                tabs: choices.map<Widget>((TabBarChoice c) {
                  return Tab(
                    icon: Icon(c.icon),
                    text: c.title,
                  );
                }).toList(),
              ),
              actions: [
                CartActionButton(),
                PopupMenuButtonProductsOverview(),
              ],
            ),
            body: TabBarView(
                children:
                    choices.map<Widget>((TabBarChoice c) => c.screen).toList()),
          );
        },
      ),
    );
  }
}

class TabBarChoice {
  final String title;
  final IconData icon;
  final Widget screen;
  const TabBarChoice({
    @required this.title,
    @required this.icon,
    @required this.screen,
  });
}

List<TabBarChoice> choices = <TabBarChoice>[
  TabBarChoice(
    title: 'Products',
    icon: Icons.border_all,
    screen: ScreenProductsOverview(),
  ),
  TabBarChoice(
    title: 'Favorites',
    icon: Icons.stars,
    screen: ScreenFavorites(),
  ),
];