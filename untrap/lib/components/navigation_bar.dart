import 'package:flutter/material.dart';

int currentPage = 1;

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.changePage});

  final void Function(int) changePage;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 60,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Theme.of(context).hintColor,
      indicatorColor: Theme.of(context).highlightColor,
      selectedIndex: currentPage,
      onDestinationSelected: (int index) {
        changePage(index);
      },
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(
            Icons.map,
            color: Theme.of(context).focusColor,
          ),
          icon: Icon(
            Icons.map_outlined,
            color: Theme.of(context).focusColor,
          ),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.timeline,
            color: Theme.of(context).focusColor,
          ),
          icon: Icon(
            Icons.timeline_outlined,
            color: Theme.of(context).focusColor,
          ),
          label: 'Lines',
        ),
      ],
    );
  }
}
