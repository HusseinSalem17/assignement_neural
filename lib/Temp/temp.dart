import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class Utilities {
  static Future<List<double>> minimizeMatrix(
    String assetImagePath,
    bool averageByRow,
  ) async {
    // Convert the image to a matrix
    final List<List<double>> matrix =
        await Utilities.convertAssetImageToMatrix(assetImagePath);

    // Compute the row or column averages
    final int rowCount = matrix.length;
    final int colCount = matrix[0].length;
    final List<double> reducedData =
        List.filled(averageByRow ? rowCount : colCount, 0.0, growable: false);
    for (int i = 0; i < (averageByRow ? rowCount : colCount); i++) {
      double sum = 0.0;
      for (int j = 0; j < (averageByRow ? colCount : rowCount); j++) {
        sum += averageByRow ? matrix[i][j] : matrix[j][i];
      }
      reducedData[i] = sum / (averageByRow ? colCount : rowCount);
    }

    return reducedData;
  }

  static Future<List<double>> convertAssetImageTo1DArray(
      String assetImagePath) async {
    // Convert the image to a minimized matrix
    final List<double> minimizedMatrix =
        await minimizeMatrix(assetImagePath, false);

    // Flatten the matrix into a 1D list
    final List<double> array = [...minimizedMatrix];

    return array;
  }

  static Future<List<List<double>>> convertAssetImageToMatrix(
      String assetImagePath) async {
    // Load the image from asset
    final ByteData imageData = await rootBundle.load(assetImagePath);
    final Uint8List bytes = imageData.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.Image image = (await codec.getNextFrame()).image;

    // Create a 2D matrix to hold the pixel values
    final int width = image.width;
    final int height = image.height;
    final List<List<double>> matrix =
        List.generate(height, (_) => List.generate(width, (_) => 0.0));

    // Get the pixel values and store them in the matrix
    final ByteData? byteData = await image.toByteData();
    final Uint8List pixels = byteData!.buffer.asUint8List();
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        final int offset = (i * width + j) * 4;
        final int red = pixels[offset];
        final int green = pixels[offset + 1];
        final int blue = pixels[offset + 2];
        final double pixelValue = (red + green + blue) / 3 / 255.0;
        matrix[i][j] = pixelValue;
      }
    }

    return matrix;
  }

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

  Future<List<double>> fileImageTo1DList(String filePath) async {
    // Load the image from file
    final File imageFile = File(filePath);
    final Uint8List bytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.Image image = (await codec.getNextFrame()).image;

    // Get the pixel values and store them in a 1D vector
    final ByteData? byteData = await image.toByteData();
    final Uint8List pixels = byteData!.buffer.asUint8List();
    final int width = image.width;
    final int height = image.height;
    final int pixelCount = width * height;
    final List<double> pixelValues = List<double>.filled(pixelCount, 0.0);
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
}
