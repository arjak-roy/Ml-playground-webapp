import 'dart:math';

class LinearRegression{
  double _weight=0;
  double _bias=0;
  int epoch;
  List<double> weightHistory = [];
  List<double> biasHistory = [];
  LinearRegression({required this.epoch, required this.learningRate});
  double learningRate;

  (double,double) gradDesc(List<double> X, List<double> Y, double w, double b) {
    int  n = X.length;
    double dw = 0;
    double db = 0;
    for (int i = 0; i < n; i++) {
      dw += -(1/n) * (Y[i] - (w*X[i] + b)) * X[i];
      db += -(1/n) * (Y[i] - (w*X[i] + b));
    }

    double wNow = w - learningRate * dw;
    double bNow = b - learningRate * db;
    return (wNow, bNow);

  }

  (double,double) fit(List<double> X, List<double> Y) {
    double w = 0;
    double b = 0;
    for (int i = 0; i < epoch; i++) {
      (w,b) = gradDesc(X, Y, w, b);
      if(i%10000 == 0){
       print("Epoch: $i, Weight: $w, Bias: $b");
      weightHistory.add(w);
      biasHistory.add(b);
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
}
