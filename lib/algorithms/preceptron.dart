import 'dart:math';

class PerceptronDeltaRule {
  List<double>? weights;
  double bias = 1;
  double? learningRate;
  List<List<List<double>>> inputs = [];
  int err = 0;

  PerceptronDeltaRule(
      {required int numInputs, required double this.learningRate}) {
    weights = List.generate(numInputs, (i) => Random().nextDouble());
  }

  int predict(List<double> inputs) {
    double weightedSum = 0;
    for (int i = 0; i < inputs.length; i++) {
      weightedSum += inputs[i] * weights![i];
    }
    weightedSum += bias;
    return weightedSum > 0 ? 1 : -1;
  }

  Future<void> train(
    List<List<double>> inputs,
    List<int> targets,
  ) async {
    print('Matrix 1: ${inputs[0]}');
    print('Matrix 2: ${inputs[1]}');
    if (!this.inputs.contains(inputs)) {
      this.inputs.add(inputs);
      print('hi');
    }
    print(this.inputs.length);

    while (true) {
      var k = 0;
      err = 0;
      for (; k < this.inputs.length; k++) {
        inputs = this.inputs[k];
        print('k: $k');
        for (int i = 0; i < inputs.length; i++) {
          print('i: $i');
          print('Matrix 1: ${inputs[0]}');
          print('Matrix 2: ${inputs[1]}');
          final prediction = predict(inputs[i]);
          final error = targets[i] - prediction;
          if (error != 0) {
            err = error;
            for (int j = 0; j < weights!.length; j++) {
              weights![j] += error * learningRate! * inputs[i][j];
            }
            bias = bias + error * learningRate!;
            print('err = $err');
          }
        }
      }

      if (err == 0) break;
    }
  }

  void clear() {
    inputs = [];
  }
}
