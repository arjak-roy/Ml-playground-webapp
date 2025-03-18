import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:provider/provider.dart';

class convTheta1 extends StatefulWidget {
  const convTheta1({super.key});

  @override
  State<convTheta1> createState() => _convTheta1State();
}

class _convTheta1State extends State<convTheta1> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Gdfitprovider>(
      builder:(context,gradModel,child)=>(gradModel.weightChange.isEmpty)? Container(
        alignment: Alignment.center,
        child: const Text("No Data",style: TextStyle(color: Colors.white),),
      ):
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
          spots: gradModel.biasHistory.map((spot) => ScatterSpot(1000*gradModel.biasHistory.indexOf(spot).toDouble() , spot, radius: 2.5)).toList().sublist(1),
              color: Colors.lightBlueAccent,
              isCurved: true,
              shadow:Shadow(color: Color.fromARGB(255, 255, 255, 255), blurRadius: 5),
              barWidth: 2,
              dotData: const FlDotData(show: false),
          )]
      )
    )

      //  ScatterChart(
      //   ScatterChartData(
      //     borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
      //     gridData: const FlGridData(show: true),
      //     titlesData: const FlTitlesData(show: true,
      //     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      //     bottomTitles: AxisTitles(axisNameWidget: Text("Epoches",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
      //     leftTitles: AxisTitles(axisNameWidget: Text("J(Theta1)",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
      //     ),
      
          // scatterSpots: gradModel.biasHistory.map((spot) => ScatterSpot(1000*gradModel.biasHistory.indexOf(spot).toDouble() , spot, radius: 2.5)).toList().sublist(1),
      
      //   ), 
      // ),
    );
  }
}