import 'package:canna_drive_main/BottomNavigation/WidgetListPage.dart';
import 'package:canna_drive_main/BottomNavigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

  class TabNavigator extends StatefulWidget {

     
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
    @override
    _TabNavigatorState createState() => _TabNavigatorState();
  }
  
  class _TabNavigatorState extends State<TabNavigator> {
 


  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => WidgetListPage(
            color: TabHelper.color(widget.tabItem),
            title: TabHelper.description(widget.tabItem),
           
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: widget.navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        });
  }
}
