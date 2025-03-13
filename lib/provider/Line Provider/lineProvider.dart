import 'package:flutter/material.dart';
import 'package:mlplayground/Models/line.dart';
import 'package:fl_chart/fl_chart.dart';

class lineprovider extends ChangeNotifier{
  List<ScatterSpot> Sctspots = [

  ];
  Line line = Line(0, 0, [],[],0,0);
  setLine(int intercept, int slope, List<double> X, List<double> Y, int sampleSize, int noise){
   line = Line(intercept, slope, X, Y, sampleSize,noise);
   line.populate();
   }
  setScatterSpots(){
    Sctspots = line.getScatterSpots();
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