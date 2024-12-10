import 'package:flutter/material.dart';

import '../utils/routes/route_names.dart';

class SplashService {
  static void gotoLanding(BuildContext context) async {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.landingScreen);

  }
}