import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:examen_flutter/screens/login_screen.dart';
import 'package:examen_flutter/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LottieBuilder.asset("assets/lotties/a.json")],
        ),
        centered: true,
        splashIconSize: 600,
        backgroundColor: myblueColor,
        nextScreen: const LoginScreen());
  }
}
