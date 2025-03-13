import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
class Line{
  final double _e = 2.71828;
  int intercept;
  int slope;
  int noise;
  List<double> X;
  List<double> Y;
  int sampleSize;
  List<ScatterSpot> Sctspots = [];
  Line(this.intercept, this.slope, this.X, this.Y, this.sampleSize,this.noise);

   double produce(double X){
    return (intercept + slope*X + Random().nextInt(noise)-0)/(10-0);
  }
  double produceSigmoid(double X){
    return 1/(1+pow(_e, X*-1.0));
  }

  void addPoint(double X, double Y){
    this.X.add(X);
    this.Y.add(Y);
  }
  void populate(){
    for (int i=0; i<sampleSize; i++){
      addPoint((i*1.0), produce(i*1.0));
      Sctspots.add(ScatterSpot(i*1.0, Y[i]*1.0, radius: 2.5,show: true));
    }
  }
  List<ScatterSpot> getScatterSpots(){
    return Sctspots;
  }
}

class RegressionLine{
  double intercept;
  double slope;
  List<double> X;
  RegressionLine(this.intercept, this.slope, this.X);
  List<FlSpot> getFlSpots(){
    List<FlSpot> spots = [];
    for (int i=0; i<X.length; i++){
      spots.add(FlSpot(i*1.0, intercept + slope*X[i]));
    }
    return spots;
  }
  
}