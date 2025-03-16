import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Gradient-Descent/sample-data.dart';
import 'package:provider/provider.dart';

class scatter extends StatefulWidget {
  const scatter({super.key});

  @override
  State<scatter> createState() => _scatterState();
}

class _scatterState extends State<scatter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<sampleData>(
      builder:(context,sampleData,child)=> ScatterChart(

        ScatterChartData(
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
      
          scatterSpots:  sampleData.Sctspots,
          
                  ), 
          swapAnimationCurve: Curves.easeInCirc,
          swapAnimationDuration: const Duration(milliseconds: 500),
      
      ),
    );
  }
}