import 'dart:math';

class PerceptronDeltaRule {
  List<double>? weights;
  double bias = 1;
  double? learningRate;
  List<List<List<double>>> inputs = [];
  int err = 0;

  //generate random weights (the length must equals the length of vectors(photo))
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
    //to store all training images(to make weight work for all)(store 2 photos every time)
    this.inputs.add(inputs);
    //just tracing
    print(this.inputs.length);

    //to repeat the training if found error
    while (true) {
      //to start from begin
      var k = 0;
      //initial error =0
      err = 0;
      for (; k < this.inputs.length; k++) {
        //to take 2 photos for training (same thing with others photos that stored)
        inputs = this.inputs[k];
        //just tracing
        print('k: $k');

        for (int i = 0; i < inputs.length; i++) {
          //just tracing
          print('i: $i');
          print('Matrix 1: ${inputs[0]}');
          print('Matrix 2: ${inputs[1]}');

          final prediction = predict(inputs[i]);
          //error => store the error for every vector(image)
          final error = targets[i] - prediction;
          //if the expected output != actual output
          if (error != 0) {
            //err for store error and check after complete epoch
            err = error;
            for (int j = 0; j < weights!.length; j++) {
              //updating weight for next image (formula)
              weights![j] += error * learningRate! * inputs[i][j];
            }
            //update the bias (formula)
            bias = bias + error * learningRate!;
            //just tracing
            print('err = $err');
          }
        }
      }
      //to continue training if error != 0
      if (err == 0) break;
    }
  }

  //clear all stored images (clear)
  void clear() {
    inputs = [];
  }
}
