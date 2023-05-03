import 'package:assigenment/utilities/resize.dart';
import 'package:assigenment/utilities/utilities.dart';

class Services {
  Future<List<double>> fileAndNormalize(String filePath) async {
    //Resize image
    final String resizedImagePath =
        await Resize.resizeImage(filePath, 400, 400);
    // Get the pixel values from the file
    final List<double> pixelValues =
        await Utilities.fileImageTo1DList(resizedImagePath);

    // Normalize the pixel values
    final List<double> normalizedPixelValues =
        Utilities.normalizePixelValues(pixelValues);

    return normalizedPixelValues;
  }

  Future<List<double>> assetAndNormalize(String assetPath) async {
    final List<double> normalizedPixelValues =
        await Utilities.convertAssetImageTo1DArray(assetPath);

    return normalizedPixelValues;
  }
}
