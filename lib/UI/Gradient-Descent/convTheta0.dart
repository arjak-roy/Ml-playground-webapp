import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:mlplayground/provider/Gradient-Descent/Model-provider.dart';
import 'package:provider/provider.dart';

class convTheta0 extends StatefulWidget {
  const convTheta0({super.key});

  @override
  State<convTheta0> createState() => _convTheta0State();
}

class _convTheta0State extends State<convTheta0> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Gdfitprovider>(
      builder:(context,gradModel,child)=> (gradModel.weightChange.isEmpty)? Container(
        alignment: Alignment.center,
        child: const Text("No Data",style: TextStyle(color: Colors.white),),
      ):
      ScatterChart(
        ScatterChartData(

          borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true,
          
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(axisNameWidget: Text("Epoches",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
          leftTitles: AxisTitles(axisNameWidget: Text("J(Theta0)",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
          ),
          scatterSpots:  gradModel.weightHistory.map((spot) => ScatterSpot(1000*gradModel.weightHistory.indexOf(spot).toDouble() , spot, radius: 2.5)).toList().sublist(1),
        ), 
      ),
    );
  }
}