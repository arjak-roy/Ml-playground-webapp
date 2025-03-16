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

  void setSampledataparms(double intercept, double slope, double noise, int SampleSize) {
    sampledataparms = Sampledataparms(intercept, slope, noise, SampleSize);
  } 
  void populate(){
    Sctspots = [];
    X=[];
    Y=[];
    X = List<double>.generate(sampledataparms.noOfDataPoints, (index) => index.toDouble() * 1.0);
    Y = List<double>.generate(sampledataparms.noOfDataPoints, (index) => sampledataparms.intercept + sampledataparms.slope * X[index] + Random().nextInt(sampledataparms.noise) - 0);
    double maxY = Y.reduce((a, b) => a > b ? a : b);
    double minY = Y.reduce((a, b) => a < b ? a : b);
    double maxX = X.reduce((a, b) => a > b ? a : b);
    double minX = X.reduce((a, b) => a < b ? a : b);

    for (int i=0; i<sampledataparms.noOfDataPoints; i++){
      Sctspots.add(ScatterSpot((X[i]-minX)/(maxX-minX), (Y[i]-minY)/(maxY-minY), radius: 2.5,show: true, color: Colors.amber[300]));
    }
    notifyListeners();
  }
  reset(){
    Sctspots = [];
    X = [];
    Y = [];
    notifyListeners();
  }
}
