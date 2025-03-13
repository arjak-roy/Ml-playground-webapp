import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mlplayground/provider/Line%20Provider/AlgoProvider.dart';
import 'package:mlplayground/provider/Line%20Provider/lineProvider.dart';
import 'package:provider/provider.dart';

class Line2chart extends StatefulWidget {

  const Line2chart({super.key});

  @override
  State<Line2chart> createState() => _Line2chartState();
}

class _Line2chartState extends State<Line2chart> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<LinReg,lineprovider, regLineProvider>(
      builder: (context,model, lineprovider, regrlne, child)=>
       ScatterChart(
        
        ScatterChartData(
          scatterTouchData: ScatterTouchData(
            enabled: true,
            touchCallback: (p0, p1) {
              if(p0.runtimeType == FlTapDownEvent){
                // regrlne.reset();
                final maxX = lineprovider.line.X.reduce((a, b) => a > b ? a : b) ;
                final minY = lineprovider.line.Y.reduce((a, b) => a < b ? a : b) ;
                final maxY = lineprovider.line.Y.reduce((a, b) => a > b ? a : b) ;
                final minX = lineprovider.line.X.reduce((a, b) => a < b ? a : b) ;
                // final maxX = 100;
                // final minY = 0;
                // final maxY =100;
                // final minX = 0;    
                final tapPosition = p0.localPosition!;
                final chartWidth = context.size!.width;
                final chartHeight = context.size!.height;
                final x = minX + (tapPosition.dx / chartWidth) * (maxX - minX);
                final y = maxY - (tapPosition.dy / chartHeight) * (maxY - minY);
                print("X: $x, Y: $y");
                lineprovider.line.X.add(x.floorToDouble());
                lineprovider.line.Y.add(y.floorToDouble());
                lineprovider.line.X.sort();
                lineprovider.line.Y.sort();
                lineprovider.addspot(ScatterSpot(x, y, radius: 2.5));
                print(lineprovider.line.X);
                print("Intercept: ${model.lr.bias}, Slope: ${model.lr.weight}");
                model.fit(lineprovider.line.X, lineprovider.line.Y);  
                print("Intercept: ${model.lr.bias}, Slope: ${model.lr.weight}");

                lineprovider.line.X.remove(x.floorToDouble());
                lineprovider.line.Y.remove(y.floorToDouble());
                regrlne.setLine(model.lr.bias, model.lr.weight, lineprovider.line.X);
                model.setmse(model.lr.mse(lineprovider.line.X, lineprovider.line.Y));
                model.setrmse(model.lr.rmse(lineprovider.line.X, lineprovider.line.Y));
                model.setr2(model.lr.r2(lineprovider.line.X, lineprovider.line.Y));

              };
            },
            ),
          minX: 0,
          minY: 0,
          // maxX: 100,
          // maxY: 100,



          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(axisNameWidget: Text("X",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false),),
          leftTitles: AxisTitles(axisNameWidget: Text("Y",style: TextStyle(color: Colors.white),),sideTitles: SideTitles(showTitles: false)),
          ),
          
          borderData: FlBorderData(show: true, border: Border(left: BorderSide(width: 1,color: Colors.white), bottom: BorderSide(width: 1,color: Colors.white))),
          scatterSpots: lineprovider.Sctspots.toList()
        ),
        swapAnimationDuration: Duration(milliseconds: 400),
        swapAnimationCurve: Curves.easeIn,
      ),
    );
  }
}