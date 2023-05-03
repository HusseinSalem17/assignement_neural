import 'dart:math';

class HammingNeuralNetwork {
  List<List<double>> weightMatrix;
  List<int> bias;
  int iterations;

  HammingNeuralNetwork(this.weightMatrix, this.bias, {this.iterations = 5});

  List<double> run(List<double> input) {
    if (input.length != weightMatrix[0].length) {
      throw Exception('Input length does not match weight matrix size');
    }

    List<double> output = List.from(input);
    for (int i = 0; i < iterations; i++) {
      List<double> newOutput = List.filled(weightMatrix.length, 0);

      for (int j = 0; j < weightMatrix.length; j++) {
        double dotProduct = 0;
        for (int k = 0; k < weightMatrix[j].length; k++) {
          dotProduct += weightMatrix[j][k] * output[k];
        }
        newOutput[j] = (dotProduct + bias[j] > 0) ? dotProduct + bias[j] : 0;
      }

      if (newOutput.join() == output.join()) {
        break;
      }

      output = newOutput;
    }

    return output;
  }

  void test(List<List<double>> inputs) {
    for (int i = 0; i < inputs.length; i++) {
      List<double> output = run(inputs[i]);
      print('Input: ${inputs[i]}');
      print('Output: $output');
    }
  }
}
