import 'dart:io';
import 'package:assigenment/algorithms/algorithm.dart';
import 'package:assigenment/services/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HammingPage extends StatefulWidget {
  const HammingPage({Key? key}) : super(key: key);

  @override
  State<HammingPage> createState() => _HammingPageState();
}

class _HammingPageState extends State<HammingPage> {
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
                              : Image.file(img1!),
                        ),
                        const SizedBox(height: 9),
                        ElevatedButton(
                          onPressed: fitchPhoto1(),
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
                              : Image.file(img2!),
                        ),
                        const SizedBox(height: 9),
                        ElevatedButton(
                          onPressed: fitchPhoto2(),
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
                          : Image.file(img3!),
                    ),
                    const SizedBox(height: 9),
                    ElevatedButton(
                      onPressed: fitchPhoto3(),
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
      maxHeight: 400,
      maxWidth: 400,
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
      maxHeight: 180,
      maxWidth: 180,
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
      maxHeight: 180,
      maxWidth: 180,
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
    final matrix = await Services.fileAndNormalize(img1!.path);
    final matrix2 = await Services.fileAndNormalize(img2!.path);

    final matrix3 = await Services.fileAndNormalize(img3!.path);

    Hamming h = Hamming(weights: [matrix, matrix2], input: matrix3);
    print('first Result : ${h.result()}');
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