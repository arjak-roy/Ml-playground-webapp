import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:provider/provider.dart';

class bestfitlines extends StatefulWidget {
  const bestfitlines({super.key});

  @override
  State<bestfitlines> createState() => _bestfitlinesState();
}

class _bestfitlinesState extends State<bestfitlines> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Gdfitprovider>(

      builder:(context,reglines,child)=> LineChart(
        
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
        LineChartData(
          minX: 0,
          minY: 0,
          borderData: FlBorderData(show: true, border: const Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(axisNameWidget: Text("nnX",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
          leftTitles: AxisTitles(axisNameWidget: Text("Y",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: reglines.FlSpots
        ),
        
      ),
    ) ;
  }
}