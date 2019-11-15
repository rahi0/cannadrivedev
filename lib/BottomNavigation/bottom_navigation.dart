import 'package:flutter/material.dart';

enum TabItem { home, request, history, profile }

class TabHelper {
  static TabItem item({int index}) {
    switch (index) {
      case 0:
        return TabItem.home;
      case 1:
        return TabItem.request;
      case 2:
        return TabItem.history;
        case 3:
        return TabItem.profile;
    }
    return TabItem.home;
  }

  static String description(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return 'Home';
      case TabItem.request:
        return 'Request';
      case TabItem.history:
        return 'History';
       case TabItem.profile:
        return 'Profile';
    }
    return '';
  }

  static IconData icon(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return Icons.home;
      case TabItem.request:
        return Icons.add_shopping_cart;
      case TabItem.history:
        return Icons.history;
       case TabItem.profile:
        return Icons.account_circle;
    }
    return Icons.layers;
  }

  static MaterialColor color(TabItem tabItem) {

    // switch (tabItem) {
    //   case TabItem.home:
    //     return Colors.white;
    //   case TabItem.tournament:
    //     return Colors.white;
    //   case TabItem.settings:
    //     return Colors.white;
    // }
    return Colors.blue;
  }
}

class BottomNavigation extends StatefulWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  BottomNavigation({this.currentTab, this.onSelectTab});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //fixedColor: Colors.white,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.request),
        _buildItem(tabItem: TabItem.history),
        _buildItem(tabItem: TabItem.profile),
      ],
      onTap: (index) => widget.onSelectTab(
            TabHelper.item(index: index),
          ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = TabHelper.description(tabItem);
    IconData icon = TabHelper.icon(tabItem);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return widget.currentTab == item ?
   Color(0xFF01D56A) : Colors.black; 
    //TabHelper.color(item) : Colors.grey;
  }
}
