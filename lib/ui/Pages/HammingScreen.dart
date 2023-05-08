import 'dart:io';
import 'package:assigenment/algorithms/Hamming.dart';
import 'package:assigenment/services/services.dart';
import 'package:assigenment/utilities/resize.dart';
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

  String? res;

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
                      child: Center(
                        child: Text(
                          '$res',
                          style: TextStyle(
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
      res = null;
    });
  }

  Future<void> getResult() async {
    var matrix = await Services.fileAndNormalize(img1!.path);
    var matrix2 = await Services.fileAndNormalize(img2!.path);
    var matrix3 = await Services.fileAndNormalize(img3!.path);

    var num = minOfThree(matrix.length, matrix2.length, matrix3.length);
    matrix = Resize.normalizeListToSize(matrix, num);
    matrix2 = Resize.normalizeListToSize(matrix2, num);
    matrix3 = Resize.normalizeListToSize(matrix3, num);

    Hamming h = Hamming(weights: [matrix, matrix2], input: matrix3);
    setState(() {
      if (h.result() == 1)
        res = 'Image 1';
      else
        res ='Image 2';
    });
  }
}

int minOfThree(int a, int b, int c) {
  return a < b ? (a < c ? a : c) : (b < c ? b : c);
}
