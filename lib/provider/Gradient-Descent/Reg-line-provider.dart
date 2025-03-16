import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/Models/line.dart';

class Reglinesprovider extends ChangeNotifier {
  List<LineChartBarData> FlSpots = [
  ];
  RegressionLine line = RegressionLine(0, 0, []);
  setLine(double intercept, double slope, List<double> X){
    line = RegressionLine(intercept, slope, X);
    FlSpots.add(
      LineChartBarData(
      spots: line.getFlSpots(),
                 barWidth: (FlSpots.length > 1)? 1: 3,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
              shadow: (FlSpots.length < 1)? Shadow(color: const Color.fromARGB(255, 255, 255, 255), blurRadius: 5):Shadow(),
              color: (FlSpots.isEmpty)?const Color.fromARGB(255, 0, 255, 187):const Color.fromARGB(176, 5, 218, 255)
  ));
    notifyListeners();
  }
  reset(){
    FlSpots = [];
    notifyListeners();
  }

} 