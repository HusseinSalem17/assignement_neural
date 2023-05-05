import 'dart:math';

class Resize {
  static List<double> normalizeListToSize(List<double> numbers, int size) {
    if(numbers.length == size) {
      return numbers;
    }
    
    double mean = numbers.reduce((a, b) => a + b) / numbers.length;
    double std = sqrt(
        numbers.map((x) => pow(x - mean, 2)).reduce((a, b) => a + b) /
            numbers.length);
    List<double> normalized = numbers.map((x) => (x - mean) / std).toList();

    if (normalized.length == size) {
      return normalized;
    } else if (normalized.length > size) {
      // Downsample the normalized list
      double step = normalized.length / size;
      List<double> downsampled = [];
      for (int i = 0; i < size; i++) {
        int j = (i * step).floor();
        downsampled.add(normalized[j]);
      }
      return downsampled;
    } else {
      // Upsample the normalized list
      double step = size / normalized.length;
      List<double> upsampled = [];
      for (int i = 0; i < size; i++) {
        int j = (i / step).floor();
        if (j < normalized.length - 1) {
          double a = normalized[j];
          double b = normalized[j + 1];
          double t = i / step - j;
          upsampled.add((1 - t) * a + t * b);
        } else {
          upsampled.add(normalized[j]);
        }
      }
      return upsampled;
    }
  }
}
