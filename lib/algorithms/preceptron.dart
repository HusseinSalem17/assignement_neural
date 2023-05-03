import 'dart:math';

class Perceptron {
  List<double>? weights;
  double? bias;
  double? learningRate;

  Perceptron({required int numInputs, required double learningRate}) {
    weights = List.generate(numInputs, (i) => Random().nextDouble());
    bias = Random().nextDouble();
    this.learningRate = learningRate;
  }

  int predict(List<double> inputs) {
    double weightedSum = 0;
    for (int i = 0; i < inputs.length; i++) {
      weightedSum += inputs[i] * weights![i];
    }
    weightedSum += bias!;
    return weightedSum > 0 ? 1 : -1;
  }

  void train(List<List<double>> inputs, List<int> targets,
      {int maxIterations = 5000}) {
    int numErrors = targets.length;
    int iteration = 0;
    while (numErrors > 0 && iteration < maxIterations) {
      numErrors = 0;
      for (int i = 0; i < inputs.length; i++) {
        final prediction = predict(inputs[i]);
        final error = targets[i] - prediction;
        if (error != 0) {
          for (int j = 0; j < weights!.length; j++) {
            weights![j] += error * learningRate! * inputs[i][j];
          }
          bias = bias! + error * learningRate!;
          numErrors++;
        }
      }
      iteration++;
    }
  }
}
