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
      selectedIndex: currentPage,
      onDestinationSelected: (int index) {
        changePage(index);
      },
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(
            Icons.map,
          ),
          icon: Icon(
            Icons.map_outlined,
          ),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: Icon(
            Icons.timeline,
          ),
          icon: Icon(
            Icons.timeline_outlined,
          ),
          label: 'Lines',
        ),
      ],
    );
  }
}
