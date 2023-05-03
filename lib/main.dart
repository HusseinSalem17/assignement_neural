import 'package:assigenment/algorithms/Hamming2.dart';
import 'package:assigenment/algorithms/algorithm.dart';
import 'package:assigenment/algorithms/preceptron.dart';
import 'package:assigenment/utilities/utilities.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // loadImageMatrix();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Image(
              image: AssetImage('assets/images/cat.0.jpg'),
            )
          ],
        ),
      ),
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