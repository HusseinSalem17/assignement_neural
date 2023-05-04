import 'dart:io';
import 'dart:math';
import 'package:assigenment/algorithms/algorithm.dart';
import 'package:assigenment/algorithms/preceptron.dart';
import 'package:assigenment/services/services.dart';
import 'package:assigenment/utilities/resize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreceptronPage extends StatefulWidget {
  const PreceptronPage({Key? key}) : super(key: key);

  @override
  State<PreceptronPage> createState() => _PreceptronPageState();
}

class _PreceptronPageState extends State<PreceptronPage> {
  final ImagePicker _picker = ImagePicker();
  File? img1, img2, img3;

  bool photo1 = false;
  bool photo2 = false;
  bool photo3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () => reset(),
              icon: const Icon(Icons.refresh_sharp),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.blueGrey,
                          height: 180,
                          width: 180,
                          child: img1 == null
                              ? const Icon(
                                  Icons.image,
                                  size: 50,
                                )
                              : Image(
                                  image: FileImage(img1!),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        const SizedBox(height: 9),
                        ElevatedButton(
                          onPressed: fitchPhoto1,
                          child: const Text('choose photo 1'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          color: Colors.blueGrey,
                          height: 180,
                          width: 180,
                          child: img2 == null
                              ? const Icon(
                                  Icons.image,
                                  size: 50,
                                )
                              : Image(
                                  image: FileImage(img2!),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        const SizedBox(height: 9),
                        ElevatedButton(
                          onPressed: fitchPhoto2,
                          child: const Text('choose photo 2'),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    Container(
                      color: Colors.blueGrey,
                      height: 180,
                      width: 180,
                      child: img3 == null
                          ? const Icon(
                              Icons.image,
                              size: 50,
                            )
                          : Image(
                              image: FileImage(img3!),
                              fit: BoxFit.fill,
                            ),
                    ),
                    const SizedBox(height: 9),
                    ElevatedButton(
                      onPressed: fitchPhoto3,
                      child: const Text('choose photo 3'),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              top: 600,
              left: 20,
              child: Container(
                width: 120,
                child: ElevatedButton(
                  onPressed: loadImageMatrix,
                  child: const Text('Show Result'),
                ),
              ),
            ),
            Positioned(
              top: 602,
              left: 170,
              child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    'Dog',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  fitchPhoto1() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile!.path);
    print('@@@@@@***Image Path***@@@@@@ ${pickedFile.path}');
    setState(() {
      try {
        img1 = file;
      } catch (e) {
        print(e);
      }
    });
  }

  fitchPhoto2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile!.path);
    setState(() {
      try {
        img2 = file;
      } catch (e) {
        print(e);
      }
    });
  }

  fitchPhoto3() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final file = File(pickedFile!.path);
    setState(() {
      try {
        img3 = file;
      } catch (e) {
        print(e);
      }
    });
  }

  reset() {
    setState(() {
      img1 = null;
      img2 = null;
      img3 = null;
    });
  }

  Future<int> showResult() async {
    return 90000000000000;
  }

  Future<void> loadImageMatrix() async {
    // final newMatrix = await Resize.resizeImage(img1!.path, 400, 400);
    // final newMatrix2 = await Resize.resizeImage(img2!.path, 400, 400);
    // final newMatrix3 = await Resize.resizeImage(img3!.path, 400, 400);

    var matrix = await Services.fileAndNormalize(img1!.path);
    var matrix2 = await Services.fileAndNormalize(img2!.path);
    var matrix3 = await Services.fileAndNormalize(img3!.path);
    var num = minOfThree(matrix.length, matrix2.length, matrix3.length);
    matrix = Resize.normalizeListToSize(matrix, num);
    matrix2 = Resize.normalizeListToSize(matrix2, num);
    matrix3 = Resize.normalizeListToSize(matrix3, num);
    final perceptron = Perceptron(numInputs: num, learningRate: 0.1);
    perceptron.train([matrix, matrix2], [1, -1]);
    final prediction = perceptron.predict(matrix3);
    print('Prediction: $prediction');
  }
}

int minOfThree(int a, int b, int c) {
  return a < b ? (a < c ? a : c) : (b < c ? b : c);
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