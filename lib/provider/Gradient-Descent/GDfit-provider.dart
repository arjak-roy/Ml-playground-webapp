import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/Algorithms/other/sampleDataThresholding.dart';
import 'package:mlplayground/Models/line.dart';

class Gdfitprovider extends ChangeNotifier {

  bool is_paused = false;
  double _weight = 0;
  double _bias = 0;
  int epoch = 10000;
  List<double> weightHistory = [];
  List<double> biasHistory = [];
  List<double> history = [];
  double learningRate = 0.001;
  List<double> weightChange = [];
  List<double> biasChange = [];
  List<LineChartBarData> FlSpots = [];
  int epochNow = 0;
  //Function for graDesc
  // (double, double) gradDesc(List<double> X, List<double> Y, double w, double b) {
  //   int n = X.length;
  //   double dw = 0;
  //   double db = 0;
  //   for (int i = 0; i < n; i++) {
  //     dw += -(1 / n) * (Y[i] - (w * X[i] + b)) * X[i];
  //     db += -(1 / n) * (Y[i] - (w * X[i] + b));
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
  //Function for fit
  Future<(double, double)> fit(List<double> X, List<double> Y) async {
    int tick = calculateThreshold(epoch);
    int tick2 = calculateThreshold2(epoch);
    reset();
    double w = 0;
    double b = 0;
    for (int i = 0; i <= epoch; i++) {

      epochNow = i;
      (w, b) = gradDesc(X, Y, w, b);
      if (i % tick == 0) {

        print("Epoch: $i, Weight: $w, Bias: $b");
        weightHistory.add(w);
        await Future.delayed(const Duration(microseconds: 200));
        biasHistory.add(b);
        await Future.delayed(const Duration(microseconds: 200));
        history.add(MSEnow(X, Y,b,w));
        print(history);
        await Future.delayed(const Duration(microseconds: 200));
        notifyListeners();
      }
      if (i % tick2 == 0 && i != 0) {
        is_paused = true;
        weightChange.add(w);
        biasChange.add(b);
        RegressionLine line =
            RegressionLine(weightChange.last, biasChange.last, X);
        FlSpots.add(LineChartBarData(
            spots: line.getFlSpots(),
            barWidth: (i != epoch) ? 1 : 3,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: false),
            shadow: (i == epoch)
                ? const Shadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 5)
                : const Shadow(),
            color: (i == epoch)
                ? const Color.fromARGB(255, 0, 255, 187)
                : const Color.fromARGB(176, 5, 218, 255)));

        notifyListeners();
      }
    }
    _weight = w;
    _bias = b;
    return (_weight, _bias);
  }

  void setLearningRate(double lr) {
    learningRate = lr;
    notifyListeners();
  } //set learning rate

  void setEpoch(int ep) {
    epoch = ep;
    notifyListeners();
  } //set epoch

  double predict(double x) => _weight * x + _bias; // predict

  double get weight => _weight; // get weight

  double get bias => _bias; // get bias

  void setWeight(double weight) => _weight = weight; // set weight

  void setBias(double bias) => _bias = bias; // set bias

  //METRICS
  double mse(List<double> X, List<double> Y) {
    double sum = 0;
    for (int i = 0; i < X.length; i++) {
      sum += pow(Y[i] - predict(X[i]), 2);
    }
    return sum / X.length;
  }

  double rmse(List<double> X, List<double> Y) {
    return sqrt(mse(X, Y));
  }

  double r2(List<double> X, List<double> Y) {
    double meanY = Y.reduce((a, b) => a + b) / Y.length;
    double sum = 0;
    for (int i = 0; i < X.length; i++) {
      sum += pow(Y[i] - meanY, 2);
    }
    return 1 - mse(X, Y) / sum;
  }
  double MSEnow(List<double> X, List<double> Y, double intercept, double slope) {
    double sum = 0;
    for (int i = 0; i < X.length; i++) {
      sum += pow(Y[i] - (slope * X[i] + intercept), 2);
    }
    return sum / X.length;
    } 
  

 void reset() {
    _weight = 0;
    _bias = 0;
    weightHistory = [];
    biasHistory = [];
    history = [];
    weightChange = [];
    biasChange = [];
    FlSpots = [];
    epochNow = 0;
    notifyListeners();
  }
}
