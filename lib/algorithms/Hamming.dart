class Hamming {
  List<List<double>>? weights;
  List<double>? input;
  List<int>? bias;
  int? r;

  Hamming({this.weights, this.input}) {
    r = weights![0].length;
    bias = List.filled(weights!.length, r!);
  }

  List<double> multiplyAndSum() {
    print(weights![0].length);
    print(weights![1].length);
    print(input!.length);
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

  List<List<double>> weightMatrixOfRNN() {
    int len = bias!.length;
    List<List<double>> weightMatrix = List.filled(len, List.filled(len, 1));

    double sigmode = 1 / (len - 1);
    for (int i = 0; i < len; i++) {
      List<double> updatedRow = List.from(weightMatrix[i]);
      updatedRow[len - i - 1] = -(sigmode - 0.5);
      weightMatrix[i] = updatedRow;
    }
    print(weightMatrix);
    return weightMatrix;
  }

  int result() {
    List<double> result = multiplyAndSum();
    List<List<double>> weightMat = weightMatrixOfRNN();
    int len = bias!.length * 2;
    print(weightMat[0]);
    print(weightMat[1]);
    while (len > 0) {
      List<double> a2 = [];
      for (int i = 0; i < weightMat.length; i++) {
        double dotProduct = 0;
        for (int j = 0; j < weightMat[i].length; j++) {
          dotProduct += weightMat[i][j] * result[j];
        }
        if (dotProduct < 0)
          a2.add(0);
        else
          a2.add(dotProduct);
      }
      result = a2;
      a2 = [];
      len--;
    }
    var res = result[0] > 0 ? 1 : -1;
    print(res);
    return res;
  }

  static bool areListsEqual(List<double> list1, List<double> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }
}
