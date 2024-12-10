import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/widgets/app_colors.dart';
import '../viewmodel/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashService.gotoLanding(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: AppColors.color_primary,
            child: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/app_icon.png')),
            )
          )),
    );
  }
}