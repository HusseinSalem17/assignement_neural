import 'package:assigenment/ui/HomePage.dart';
import 'package:assigenment/ui/Pages/HammingScreen.dart';
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
      },
    );
  }
}

/*
Future<void> loadImageMatrix() async {
  final matrix =
      await Temp.convertAssetImageTo1DArray('assets/images/dog.11.jpg');
  final matrix2 =
      await Temp.convertAssetImageTo1DArray('assets/images/cat.10.jpg');

  final matrix3 =
      await Temp.convertAssetImageTo1DArray('assets/images/dog.10.jpg');

  final matrix4 =
      await Utilities.normalizedPixelValues('assets/images/dog.11.jpg');
  final matrix5 =
      await Utilities.normalizedPixelValues('assets/images/cat.10.jpg');
  final matrix6 =
      await Utilities.normalizedPixelValues('assets/images/dog.10.jpg');
  List<List<double>> l1 = [matrix4, matrix5];
  final bias = [0, 0];
  final h2 = HammingNeuralNetwork(l1, bias);
  final result1 = h2.run(matrix6);
  print('First Result: $result1');

  Hamming h1 = Hamming(weights: l1, input: matrix6);
  print('Second Result : ${h1.result()}');

  print(' this length matrix1 : ${matrix.length}');
  print(' this length matrix2 : ${matrix2.length}');
  print(' this length matrix3 : ${matrix3.length}');
  print(' this length matrix4 : ${matrix4.length}');

  print(' this matrix1 : $matrix');
  print(' this matrix2 : $matrix2');
  print('matrix 3 : $matrix3');
  print('matrix 4 : $matrix4');

  List<List<double>> l = [matrix, matrix2];
  Hamming h = Hamming(weights: l, input: matrix3);
  print('Thired Result : ${h.result()}');

  final perceptron = Perceptron(numInputs: 400, learningRate: 0.1);
  perceptron.train([matrix, matrix2], [1, -1]);

  final prediction = perceptron.predict(matrix3);
  print('Prediction: $prediction');
}
*/
