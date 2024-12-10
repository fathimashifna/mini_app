import 'package:flutter/material.dart';

import '../utils/routes/route_names.dart';

class LandingViewModel {
  static void gotoHome(BuildContext context) async {
      Navigator.pushNamed(context, RouteNames.home);

  }
}