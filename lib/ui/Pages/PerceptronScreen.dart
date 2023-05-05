import 'dart:io';
import 'package:assigenment/algorithms/preceptron.dart';
import 'package:assigenment/services/services.dart';
import 'package:assigenment/utilities/resize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PerceptronPage extends StatefulWidget {
  const PerceptronPage({Key? key}) : super(key: key);

  @override
  State<PerceptronPage> createState() => _PerceptronPageState();
}

class _PerceptronPageState extends State<PerceptronPage> {
  File? img1, img2, img3;
  bool isLoading = false;

  late final PerceptronDeltaRule perceptron =
      PerceptronDeltaRule(numInputs: 400, learningRate: 0.1);

  int? res;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.teal,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                        IconButton(
                          onPressed: () => reset(),
                          icon: const Icon(Icons.refresh_sharp),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildGestureDetector('Select photo 1', img1, fitchPhoto1),
                      const SizedBox(height: 9),
                      buildGestureDetector('Select photo 2', img2, fitchPhoto2),
                      const SizedBox(height: 9),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: learn,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        'Learn',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Container(
                    padding: EdgeInsets.zero,
                    width: 25,
                    height: 25,
                    child: Visibility(
                      visible: isLoading,
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildGestureDetector('Select photo 3', img3, fitchPhoto3),
                ],
              ),
              Expanded(
                  child: Container(
                height: 5,
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      width: 120,
                      child: ElevatedButton(
                        onPressed: getResult,
                        child: const Text('Show Result'),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child:  Center(
                        child: Text(
                          '$res',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildGestureDetector(String txt, File? img, selectedPhoto) {
    return GestureDetector(
      onTap: selectedPhoto,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff001456),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 170,
        width: 170,
        child: img == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    txt,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: FileImage(img),
                  fit: BoxFit.fill,
                ),
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
    print('@@@@@@***Image Path***@@@@@@ ${pickedFile.path}');
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
    print('@@@@@@***Image Path***@@@@@@ ${pickedFile.path}');
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
      perceptron.clear();
      isLoading = false;
    });
  }

  Future<int> showResult() async {
    return 90000000000000;
  }

  Future<void> learn() async {
    setState(() {
      isLoading = true;
    });
    var matrix = await Services.fileAndNormalize(img1!.path);
    var matrix2 = await Services.fileAndNormalize(img2!.path);
    matrix = Resize.normalizeListToSize(matrix, 400);
    matrix2 = Resize.normalizeListToSize(matrix2, 400);
    perceptron.train([matrix, matrix2], [1, -1]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getResult() async {
    var matrix3 = await Services.fileAndNormalize(img3!.path);
    matrix3 = Resize.normalizeListToSize(matrix3, 400);
    setState(() {
      res = perceptron.predict(matrix3);
    });
  }
}
