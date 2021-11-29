import 'package:flutter/material.dart';
import '../screens/base_screen.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class AppRouter {
  MaterialPageRoute getScreen(Screen screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return getScreen(const HomeScreen());
      case SecondScreen.routeName:
        return getScreen(const SecondScreen());
      case ThirdScreen.routeName:
        return getScreen(const ThirdScreen());
      default:
        return null;
    }
  }
}
