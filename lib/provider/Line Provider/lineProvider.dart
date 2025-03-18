import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mlplayground/Models/line.dart';
import 'package:fl_chart/fl_chart.dart';

class lineprovider extends ChangeNotifier{
  List<ScatterSpot> Sctspots = [

  ];
  Line line = Line(0, 0, [],[],0,0);
  double correlation = 0.0;

  double calculateCorrelation(List<double> x, List<double> y) {
  if (x.length != y.length || x.isEmpty) {
    throw ArgumentError('Lists must have the same non-zero length.');
  }

  int n = x.length;

  // Calculate means of X and Y
  double meanX = x.reduce((a, b) => a + b) / n;
  double meanY = y.reduce((a, b) => b + a) / n;

  // Calculate the numerator and denominator for the formula
  double numerator = 0.0;
  double sumXSquared = 0.0;
  double sumYSquared = 0.0;

  for (int i = 0; i < n; i++) {
    double deltaX = x[i] - meanX;
    double deltaY = y[i] - meanY;

    numerator += deltaX * deltaY;
    sumXSquared += deltaX * deltaX;
    sumYSquared += deltaY * deltaY;
  }

  double denominator = sqrt(sumXSquared * sumYSquared);

  if (denominator == 0) {
    throw ArgumentError('Denominator is zero, correlation cannot be calculated.');
  }

  // Correlation coefficient
  return numerator / denominator;
}
 
  setLine(int intercept, int slope, List<double> X, List<double> Y, int sampleSize, int noise){
   line = Line(intercept, slope, X, Y, sampleSize,noise);
   line.populate();
   }
  setScatterSpots(){
    Sctspots = line.getScatterSpots();
    correlation = calculateCorrelation(line.X, line.Y);
    notifyListeners();
  }
  reset(){
    Sctspots = [];
    notifyListeners();
  }
  addspot(ScatterSpot spot){
    Sctspots.add(spot);
    notifyListeners();
  }
}

class regLineProvider extends ChangeNotifier{
  List<FlSpot> FlSpots = [
  ];
  RegressionLine line = RegressionLine(0, 0, []);
  setLine(double intercept, double slope, List<double> X){
    line = RegressionLine(intercept, slope, X);
    FlSpots = line.getFlSpots();
    
    notifyListeners();

  }
  reset(){
    FlSpots = [];
    notifyListeners();
  }

}