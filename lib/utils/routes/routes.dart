import 'package:flutter/material.dart';
import 'package:mini_app/utils/routes/route_names.dart';

import '../../view/description_Screen.dart';
import '../../view/home_screen.dart';
import '../../view/landing_screen.dart';
import '../../view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.home):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case (RouteNames.landingScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LandingScreen());

      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
