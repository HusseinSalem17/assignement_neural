class Hamming {
  List<List<double>>? weights;
  List<double>? input;
  List<int>? bias;

  //to get the length of 1 vector (to put it in bias),that's how hamming work
  int? r;

  //Hamming have 2 phases => 1.FeedForward neural network, 2.Recurrent neural network
  Hamming({this.weights, this.input}) {
    r = weights![0].length;
    bias = List.filled(weights!.length, r!);
  }

  //First FeedForward neural Network
  List<double> feedforwardPhase() {
    //Throw Exception if weights OR input OR bias -> null
    if (weights == null ||
        weights!.isEmpty ||
        input == null ||
        input!.isEmpty ||
        bias == null ||
        bias!.isEmpty) {
      throw Exception('Weights, input, or bias list is empty');
    }

    final List<double> result = [];
    for (int i = 0; i < weights!.length; i++) {
      if (weights![i].length != input!.length) {
        throw Exception('Weights and input dimensions do not match');
      }

      double dotProduct = 0;
      for (int j = 0; j < input!.length; j++) {
        dotProduct += weights![i][j] * input![j];
      }
      result.add(dotProduct + bias![i]);
    }
    return result;
  }

  //Second Recurrent neural Network (Here to get the matrix of recurrent)
  List<List<double>> weightMatrixOfRecurrent() {
    int s = bias!.length; // s=> to get number of neurons
    List<List<double>> weightMatrix = List.filled(s, List.filled(s, 1));

    double sigmoid = 1 / (s - 1);
    for (int i = 0; i < s; i++) {
      //updatedRow => because if changed value in weightMatrix all values will change(so used it then equals it with the vector in weightMatrix)
      List<double> updatedRow = List.from(weightMatrix[i]);
      //change value of secondary diagonal to epsilon
      updatedRow[s - i - 1] = -(sigmoid - 0.5);
      //change the old vector in weightMatrix to newVector
      weightMatrix[i] = updatedRow;
    }

    return weightMatrix;
  }

  //to get the result after calling feedForwardPhase and recurrentPhase
  int resultFromRecurrentPhase() {
    //the result form feedforward
    List<double> result = feedforwardPhase();
    //weightMatrix of Recurrent Phase
    List<List<double>> weightMat = weightMatrixOfRecurrent();
    //multiplied with 2 to insure making one value equals 0 (more repeating)
    int len = bias!.length * 2;
    //Recurrent Phase
    while (len > 0) {
      List<double> a2 = [];
      for (int i = 0; i < weightMat.length; i++) {
        double dotProduct = 0;
        for (int j = 0; j < weightMat[i].length; j++) {
          dotProduct += weightMat[i][j] * result[j];
        }
        if (dotProduct < 0) {
          a2.add(0);
        } else {
          a2.add(dotProduct);
        }
      }
      result = a2;
      a2 = [];
      len--;
    }
    var res = result[0] > 0 ? 1 : -1;
    return res;
  }
}
