
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Resize {
  static Future<String> resizeImage(
      String imagePath, int width, int height) async {
    // Read the image file
    final File imageFile = File(imagePath);
    final Uint8List imageData = await imageFile.readAsBytes();

    // Resize the image
    final List<int> compressedData =
        await FlutterImageCompress.compressWithList(
      imageData,
      minHeight: height,
      minWidth: width,
    );

    // Save the resized image to a temporary file
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File tempFile = File(tempPath);
    await tempFile.writeAsBytes(compressedData);

    // Return the path of the resized image
    return tempPath;
  }

  static Future<String> resizeImageFromAsset(
      String assetPath, int width, int height) async {
    // Load the image bytes from the asset
    final ByteData imageData = await rootBundle.load(assetPath);
    final Uint8List imageBytes = imageData.buffer.asUint8List();

    // Resize the image
    final List<int> compressedData =
        await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: height,
      minWidth: width,
    );

    // Save the resized image to a temporary file
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File tempFile = File(tempPath);
    await tempFile.writeAsBytes(compressedData);

    // Return the path of the resized image
    return tempPath;
  }
}
