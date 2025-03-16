import 'package:flutter/material.dart';
import 'package:mlplayground/Algorithms/Regression/Linear%20Regression/LinearRegression.dart';
import 'package:mlplayground/Algorithms/Regression/Linear%20Regression/LinearRegression_gd.dart';

class GradModel extends ChangeNotifier{

  LinearRegression lr = LinearRegression(epoch: 100000, learningRate: 0.0001 );
  double mse = 0;
  double r2 = 0;
  double rmse = 0;
  List<double> weightHistory = [];
  List<double> biasHistory = [];

  Future<void> fit(List<double>X, List<double>Y)async{
    lr.weightChange.clear();
    lr.biasChange.clear();
    lr.biasHistory.clear();
    lr.weightHistory.clear();
    await lr.fit(X, Y);
    mse = lr.mse(X, Y);
    rmse = lr.rmse(X, Y);
    r2 = lr.r2(X, Y);
    weightHistory = lr.weightHistory;
    biasHistory = lr.biasHistory;
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
  reset(){
    weightHistory.clear();
    biasHistory.clear();
    notifyListeners();
    }

}