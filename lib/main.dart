import 'package:assigenment/ui/HomePage.dart';
import 'package:assigenment/ui/Pages/HammingScreen.dart';
import 'package:assigenment/ui/Pages/PerceptronScreen.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        'hamming':(context)=> const Hamming(),
        'perceptron':(context)=> const Perceptron(),
      },
    );
  }
}

