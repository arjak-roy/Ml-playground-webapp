// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mlplayground/Algorithms/Regression/Linear%20Regression/LinearRegression.dart';

class LinReg extends ChangeNotifier{
  int intercept = 0;
  int slope = 0;
  int sampleSize = 0;
  int noise = 1;
  LinearRegression lr = LinearRegression(epoch: 500, learningRate: 0.01 );
  double mse = 0;
  double r2 = 0;
  double rmse = 0;
  fit(List<double>X, List<double>Y){
    lr.fit(X, Y);
  }
  setIntercept(int Intercept){
    intercept = Intercept;
    notifyListeners();
  }
  setSlope(int Slope){
    slope = Slope;
    notifyListeners();
  }
  setSampleSize(int Ss){
    sampleSize = Ss;
    notifyListeners();
  }
  setNoise(int Noise){
    noise = Noise;
    notifyListeners();
  }
  setmse(double MSE){
    mse = MSE;
    notifyListeners();
  }
  setrmse(double RMSE){
    rmse = RMSE;
    notifyListeners();
  }
  setr2(double R2){
      r2 = R2;
      notifyListeners();
  }

}