import 'package:flutter/material.dart';
import 'package:weeshr/modules/weather/presentation/screen/Home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routeName = settings.name;
    debugPrint("Current Screen Route -> $routeName");


    switch (routeName) {
      case HomeScreen.routeName:
        const _screen = HomeScreen();
        return MaterialPageRoute(builder: (_) => _screen);

     

      default:
        const _screen = HomeScreen();
        return MaterialPageRoute(builder: (_) => _screen);
    }
  }
}
