// flutter
import 'package:flutter/material.dart';
// utils
import '../../../utils/enums.dart';
// provider
import '../../../providers/provider_UI.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PopupMenuButtonProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ui = Provider.of<ProviderUI>(context);
    final isGridView = ui.isGridView;

    return PopupMenuButton(
        offset: Offset(0, 100),
        elevation: 5,
        onSelected: (choice) {
          switch (choice) {
            case TileType.grid:
              ui.setGridView();
              break;
            case TileType.list:
              ui.setListView();
              break;
          }
        },
        itemBuilder: (BuildContext ctx) {
          return <PopupMenuEntry<dynamic>>[
            PopupMenuItem(
              child: Text(
                'View type',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              enabled: false,
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: TileType.grid,
              child: ListTile(
                title: const Text('Grid'),
                leading: Icon(
                  isGridView ? Icons.grid_on : Icons.grid_off,
                  color: isGridView ? theme.accentColor : Colors.grey,
                ),
              ),
            ),
            PopupMenuItem(
              value: TileType.list,
              child: ListTile(
                title: const Text('List'),
                leading: Icon(
                  isGridView ? Icons.list : Icons.view_list,
                  color: isGridView ? Colors.grey : theme.accentColor,
                ),
              ),
            ),
          ];
        });
  }
}
