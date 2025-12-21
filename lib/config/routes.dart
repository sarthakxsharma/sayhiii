import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/home_drawer/drawer.dart' as drawer_view;

class AppRoutes {
  // Route names
  static const String home = '/';
  static const String drawer = '/drawer';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(title: 'SayHi Home Page'),
          settings: settings,
        );
      case drawer:
        return MaterialPageRoute(
          builder: (_) => const drawer_view.Drawer(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  // Get route name from enum or string
  static String getRouteName(String route) {
    return route;
  }
}
