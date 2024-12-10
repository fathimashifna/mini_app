import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/widgets/app_colors.dart';
import '../viewmodel/landing_viewmodel.dart';
import '../viewmodel/splash_service.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: AppColors.color_primary,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.68,
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/images/splash_image.png')),
                Text('An Evolving', style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: AppColors.color_text, fontSize: 26),

                ),),
                Text('collection of treatments', style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: AppColors.color_text, fontSize: 26),

                ),),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    LandingViewModel.gotoHome(context);
                  },
                  color: AppColors.color_button,
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )),
    );
  }
}