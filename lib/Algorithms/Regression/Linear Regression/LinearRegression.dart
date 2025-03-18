  /// Gradient Descent algorithm, which is an optimization algorithm used to find the values of the parameters that minimize the cost function.
  /// 
  /// The cost function is the mean squared error between the predictions and the actual values.
  /// 
  /// The algorithm works by iteratively updating the parameters in the direction of the negative gradient of the cost function.
  /// 
  /// The gradient of the cost function is calculated as the sum of the gradients of the cost function with respect to each parameter, divided by the number of data points.
  /// 
  /// The gradients of the cost function with respect to each parameter are calculated as the derivative of the cost function with respect to each parameter, multiplied by the learning rate.
  /// 
  /// The learning rate is a hyperparameter that determines how quickly the algorithm converges.
  /// 
  /// The algorithm is stopped when the number of epochs reaches the specified limit.
  ///
import 'dart:math';


class LinearRegression{
  double _weight=0;
  double _bias=0;
  int epoch;
  List<double> weightHistory = [];
  List<double> biasHistory = [];
  List<double> history = [];
  double learningRate;
  List<double> weightChange = [];
  List<double> biasChange = [];
  LinearRegression({required this.epoch, required this.learningRate});

  // (double,double) gradDesc(List<double> X, List<double> Y, double w, double b) {
  //   int  n = X.length;
  //   double dw = 0;
  //   double db = 0;
  //   for (int i = 0; i < n; i++) {
  //     dw += -(1/n) * (Y[i] - (w*X[i] + b)) * X[i];
  //     db += -(1/n) * (Y[i] - (w*X[i] + b));
  //   }

  //   double wNow = w - learningRate * dw;
  //   double bNow = b - learningRate * db;
  //   return (wNow, bNow);

  // }
double clip(double value, double threshold) {
  return value.clamp(-threshold, threshold);
}

(double, double) gradDesc(List<double> X, List<double> Y, double w, double b) {
  int n = X.length;
  double dw = 0;
  double db = 0;
  for (int i = 0; i < n; i++) {
    dw += -(1 / n) * (Y[i] - (w * X[i] + b)) * X[i];
    db += -(1 / n) * (Y[i] - (w * X[i] + b));
  }
  // Clip gradients
  dw = clip(dw, 10.0); // Adjust threshold as needed
  db = clip(db, 10.0);
  double wNow = w - learningRate * dw;
  double bNow = b - learningRate * db;
  return (wNow, bNow);
}

  /// Fits the linear regression model to the given data by minimizing the cost function using gradient descent.
  /// 
  /// The function takes two lists of doubles, X and Y, as input, where X is the list of feature values and Y is the list of target values.
  /// 
  /// The function returns a tuple of two doubles, representing the weight and bias of the linear regression model.
  /// 
  /// The function also updates the weightHistory, biasHistory, and history lists, which contain the weights, biases, and cost function values at each epoch, respectively.
  /// 
  /// The function also updates the weightChange and biasChange lists, which contain the weights and biases at each 10000th epoch, respectively.
  /// 
  (double,double) fit(List<double> X, List<double> Y) {
    double w = 0;
    double b = 0;
    for (int i = 0; i < epoch; i++) {
      (w,b) = gradDesc(X, Y, w, b);
      if(i%1000 == 0){
       print("Epoch: $i, Weight: $w, Bias: $b");
      weightHistory.add(w);
      biasHistory.add(b);
      history.add(mse(X, Y));
      }  
      if(i%10000 == 0){
        weightChange.add(w);
        biasChange.add(b);
      }
    }
    _weight = w;
    _bias = b;
    return (_weight, _bias);
  }
  double predict(double x) => _weight * x + _bias; // predict
  double get weight => _weight; // get weight
  double get bias => _bias; // get bias
  void setWeight(double weight) => _weight = weight; // set weight
  void setBias(double bias) => _bias = bias; // set bias
  double mse(List<double> X, List<double> Y){
    double sum = 0;
    for (int i = 0; i < X.length; i++) {
      sum += pow(Y[i] - predict(X[i]), 2);
    }
    return sum / X.length;
  }
  double rmse(List<double> X, List<double> Y){
    return sqrt(mse(X, Y));
  }
  double r2(List<double> X, List<double> Y){
    double meanY = Y.reduce((a, b) => a + b) / Y.length;
    double sum = 0;
    for (int i = 0; i < X.length; i++) {
      sum += pow(Y[i] - meanY, 2);
    }
    return 1 - mse(X, Y) / sum;
  }
  // double accuracy(List<double>X, List<double>Y){
  //   double acc = 0.0;
  //   for(double i in X){

  //   }
  //   return acc;
  // }
}
