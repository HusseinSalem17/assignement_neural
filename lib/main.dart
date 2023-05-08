import 'package:assigenment/ui/HomePage.dart';
import 'package:assigenment/ui/Pages/HammingScreen.dart';
import 'package:assigenment/ui/Pages/HebbianScreen.dart';
import 'package:assigenment/ui/Pages/PerceptronScreen.dart';
import 'package:assigenment/ui/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(67, 34, 103, 1),
        splash: const AnimatedSplashScreenAi(),
        animationDuration: const Duration(seconds: 4),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        splashIconSize: 800,
        curve: Curves.easeInOutCubicEmphasized,
        nextScreen: const HomePage(),
      ),
      routes: {
        'hamming': (context) => const HammingPage(),
        'perceptron': (context) => const PerceptronPage(),
        'Hebbian': (context) => const HebbianPage(),
      },
    );
  }
}

