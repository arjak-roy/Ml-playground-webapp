import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Line%20Provider/lineProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LineChartSample extends StatelessWidget {

   LineChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<regLineProvider>(
      
      builder:(context,regLineProvider,child)=>(regLineProvider.line.intercept.isNaN)?Container(
        alignment: Alignment.center,
        child: const Text("Learning Rate too high",style: TextStyle(color: Colors.white),),
      ): LineChart(
        
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        LineChartData(
          
            minX: 0,
            minY: 0,

            borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
      
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(axisNameWidget: Text("nnX",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
            leftTitles: AxisTitles(axisNameWidget: Text("Y",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
            ),
          lineBarsData: [
      
            LineChartBarData(
              spots: regLineProvider.FlSpots,
              barWidth: 1,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
              shadow: Shadow(color: const Color.fromARGB(214, 255, 255, 255), blurRadius: 5),
            ),
          ],
        ),
      ),
    );
  }
}