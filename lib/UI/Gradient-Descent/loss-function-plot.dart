import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:provider/provider.dart';

class lossConvergence extends StatefulWidget {
  const lossConvergence({super.key});

  @override
  State<lossConvergence> createState() => _lossConvergenceState();
}

class _lossConvergenceState extends State<lossConvergence> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Gdfitprovider>(
      builder:(context,gradModel,child)=>(gradModel.weightChange.isEmpty)? Container(
        alignment: Alignment.center,
        child: const Text("No Data",style: TextStyle(color: Colors.white),),
      )
      :
      //  ScatterChart(
      //   ScatterChartData(
      //     borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
      //     gridData: const FlGridData(show: true),
      //     titlesData: const FlTitlesData(show: true,
      //     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //     bottomTitles: AxisTitles(axisNameWidget: Text("Epoches",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
      //     leftTitles: AxisTitles(axisNameWidget: Text("Loss",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
      //     ),
      
      //     scatterSpots: gradModel.history.map((spot) => ScatterSpot(1000*gradModel.history.indexOf(spot).toDouble() , spot, radius: 2.5)).toList().sublist(1),
      
      //   ), 
      // ),
      LineChart(
        LineChartData(
          borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(axisNameWidget: Text("Epoches",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
          leftTitles: AxisTitles(axisNameWidget: Text("Loss",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: gradModel.history.map((spot) => FlSpot(1000*gradModel.history.indexOf(spot).toDouble() , spot)).toList().sublist(1),
              color: Colors.lightBlueAccent,
              isCurved: true,
              barWidth: 2,
              dotData: const FlDotData(show: false),
          )]
      )
    ));
  }
}