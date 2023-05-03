import 'package:flutter/material.dart';

class Perceptron extends StatefulWidget {
  const Perceptron({Key? key}) : super(key: key);

  @override
  State<Perceptron> createState() => _PerceptronState();
}

class _PerceptronState extends State<Perceptron> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(),
    );
  }
}
