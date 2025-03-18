// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/Models/sample-data-parms.dart';

// ignore: camel_case_types
class sampleData extends ChangeNotifier {
  List<ScatterSpot> Sctspots = [];
  List<double> X = [];
  List<double> Y = [];
  Sampledataparms sampledataparms = Sampledataparms(0,0,0,0);
  double corr = 0.0;

  void setSampledataparms(double intercept, double slope, double noise, int SampleSize) {
    sampledataparms = Sampledataparms(intercept, slope, noise, SampleSize);
  } 

  void populate(){
    Sctspots = [];
    X=[];
    Y=[];
    X = List<double>.generate(sampledataparms.noOfDataPoints, (index) => index.toDouble() * 1.0);
    Y = List<double>.generate(sampledataparms.noOfDataPoints, (index) => sampledataparms.intercept + sampledataparms.slope * X[index] + Random().nextInt(sampledataparms.noise) - 0);
    //Normalizing the data
    double maxY = Y.reduce((a, b) => a > b ? a : b);
    double minY = Y.reduce((a, b) => a < b ? a : b);
    double maxX = X.reduce((a, b) => a > b ? a : b);
    double minX = X.reduce((a, b) => a < b ? a : b);
    for (int i=0; i<sampledataparms.noOfDataPoints; i++){
      Sctspots.add(ScatterSpot((X[i]-minX)/(maxX-minX), (Y[i]-minY)/(maxY-minY), radius: 2.5,show: true, color: Colors.amber[300]));
    }
    corr = calculateCorrelation(X, Y);
    notifyListeners();
  }

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

  reset(){
    corr = 0.00;
    Sctspots = [];
    X = [];
    Y = [];
    notifyListeners();
  }
}
