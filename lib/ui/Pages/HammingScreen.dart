import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Hamming extends StatefulWidget {
  const Hamming({Key? key}) : super(key: key);

  @override
  State<Hamming> createState() => _HammingState();
}

class _HammingState extends State<Hamming> {
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
                          onPressed: () => fitchPhoto1(),
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
                          onPressed: () => fitchPhoto2(),
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
                      onPressed: () => fitchPhoto3(),
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
                  onPressed: () {},
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
      maxHeight: 180,
      maxWidth: 180,
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
}
