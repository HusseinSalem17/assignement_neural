import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;


class Normalization {
  
  static Future<List<double>> assetImageTo1DList(String assetImagePath) async {
    // Load the image from assets
    final ByteData imageData = await rootBundle.load(assetImagePath);
    final Uint8List bytes = imageData.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.Image image = (await codec.getNextFrame()).image;

    // Convert the image to a 1D array of pixel values
    final int width = image.width;
    final int height = image.height;
    final List<double> pixelValues = List<double>.filled(width * height, 0.0);
    final ByteData? byteData = await image.toByteData();
    final Uint8List pixels = byteData!.buffer.asUint8List();
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        final int offset = (i * width + j) * 4;
        final int red = pixels[offset];
        final int green = pixels[offset + 1];
        final int blue = pixels[offset + 2];
        final double pixelValue = (red + green + blue) / 3 / 255.0;
        pixelValues[i * width + j] = pixelValue;
      }
    }

    return pixelValues;
  }

  static Future<List<double>> normalizedPixelValues(
      String assetImagePath) async {
    // Convert the image to a 1D array of pixel values
    final List<double> pixelValues = await assetImageTo1DList(assetImagePath);

    // Calculate the mean and standard deviation of the pixel values
    final double sum = pixelValues.reduce((a, b) => a + b);
    final double mean = sum / pixelValues.length;
    final double variance =
        pixelValues.map((x) => pow(x - mean, 2)).reduce((a, b) => a + b) /
            pixelValues.length;
    final double standardDeviation = sqrt(variance);

    // Normalize the pixel values
    final List<double> normalizedPixelValues =
        pixelValues.map((x) => (x - mean) / standardDeviation).toList();

    return normalizedPixelValues;
  }
}
