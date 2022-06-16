import 'package:flutter/material.dart';

class CustomNavigation extends StatelessWidget {
  List<IconButton> navigationItems = [];
  ValueChanged<int> onTap;
  int index;

  CustomNavigation({
    Key? key,
    List<IconButton>? items,
    required this.onTap,
    required this.index,
  }) : super(key: key) {
    navigationItems = _getNavigationItems(items);
  }

  List<IconButton> _getNavigationItems(List<IconButton>? items) {
    return items ?? [];
  }

  Color getIconColor(int iconIndex) {
    return iconIndex == index ? Colors.red.shade700 : Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // bottom navigation bar on scaffold
      child: Row(
        // children inside bottom appbar
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navigationItems.isNotEmpty
            ? navigationItems
            : [
          IconButton(
            icon: const Icon(Icons.search),
            color: getIconColor(0),
            iconSize: 30,
            onPressed: () {
              onTap(0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            color: getIconColor(1),
            iconSize: 30,
            onPressed: () {
              onTap(1);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: getIconColor(2),
            iconSize: 30,
            onPressed: () {
              onTap(2);
            },
          ),
        ],
      ),
    );
  }
}

