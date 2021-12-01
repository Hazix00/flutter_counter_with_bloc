import 'package:flutter/material.dart';
import 'package:flutter_counter_with_bloc/presentation/screens/settings_screen.dart';
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
      case SettingsScreen.routeName:
        return getScreen(const SettingsScreen());
      default:
        return null;
    }
  }
}
