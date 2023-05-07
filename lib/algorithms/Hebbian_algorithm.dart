import 'dart:math';

class hebbian {
  List<double> vector1; //image 1
  List<double> vector2; //image 2
  List<double> input; //check image
  List<List<double>> target = [
    [-1, 1]
  ]; //target of system
  List<List<double>> weightMatrix = [];
  hebbian(
      {required List<double> this.vector1,
      required List<double> this.vector2,
      required List<double> this.input});
  //
  List<List<double>> matrixOfInputs() {
    var matrix = [vector1, vector2];
    return matrix;
  }

  //multiply two Matrices
  List<List<double>> multiply(List<List<double>> a, List<List<double>> b) {
    List<List<double>> result =
        List.generate(a.length, (i) => List.generate(b[0].length, (j) => 0));

    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < b[0].length; j++) {
        for (int k = 0; k < b.length; k++) {
          result[i][j] += a[i][k] * b[k][j];
        }
      }
    }

    return result;
  }

  //get transpose of matrix
  List<List<double>> transpose(List<List<double>> a) {
    List<List<double>> result =
        List.generate(a[0].length, (i) => List.generate(a.length, (j) => 0));
    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < a[0].length; j++) {
        result[j][i] = a[i][j];
      }
    }
    return result;
  }

  //multiply matrix have one row with vector(list)
  double mulList(List<List<double>> list0, List<double> list1) {
    double result = 0;
    for (int i = 0; i < list1.length; i++) result += list0[0][i] * list1[i];

    return result;
  }

  //check if input vectors is orthogonal or not
  bool orthogonal() {
    double mul = 0;
    for (int i = 0; i < vector1.length; i++) {
      mul += vector1[i] * vector2[i];
    }

    return mul == 0 ? true : false;
  }

  //get normalize vector
  List<double> makeNormalized(List<double> vector) {
    double orthog = 0;
    for (int i = 0; i < vector.length; i++) {
      orthog += (vector[i] * vector[i]);
    }
    orthog = sqrt(orthog);
    for (int i = 0; i < vector.length; i++) {
      vector[i] /= orthog;
    }
    return vector;
  }

  //get inverse of matrix 2*2
  //   [ a b ]
  //   [ c d ]^-1 = 1 / (ad - bc) * [ d -b ]
  //                                [ -c a ]
  List<List<double>> inverse(List<List<double>> matrix) {
    List<List<double>> result =
        List.generate(2, (i) => List.generate(2, (j) => 0));
    double det =
        1 / (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]);
    result[0][0] = det * matrix[1][1];
    result[0][1] = det * -1 * matrix[0][1];
    result[1][0] = det * -1 * matrix[1][0];
    result[1][1] = det * matrix[0][0];
    return result;
  }

  //calculate P+ by this equation (Pt * P)-1 * Pt
  List<List<double>> p_plus() {
    List<List<double>> temp = multiply(
        inverse(multiply(matrixOfInputs(), transpose(matrixOfInputs()))),
        matrixOfInputs());

    return temp;
  }

  //main method: it has a basic layout of hebian algorithm.
  List<List<double>> run() {
    if (orthogonal()) {
      weightMatrix = multiply(target, matrixOfInputs());
      return weightMatrix;
      //---------------------------------------------------------
    } else {
      //if not orthogonal then get normalize vector and check again
      List<double> NormVector1 = makeNormalized(vector1);
      List<double> NormVector2 = makeNormalized(vector2);
      List<List<double>> NormMatrix = [NormVector1, NormVector2];
      weightMatrix = multiply(target, NormMatrix);
      if (mulList(weightMatrix, NormVector1) == -1 &&
          mulList(weightMatrix, NormVector2) == 1)
        return weightMatrix;
      //---------------------------------------------------------
      else {
        //pseudoinverse Rule
        weightMatrix = multiply(target, p_plus());
        return weightMatrix;
      }
    }
  }

  //determine if input vector closer to vector 1 or 2
  int determine() {
    run();
    double result = mulList(weightMatrix, input);
    return result <= 0 ? -1 : 1;
  }
}
