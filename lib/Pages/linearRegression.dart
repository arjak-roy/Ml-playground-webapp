import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mlplayground/UI/ontapExpand.dart';
import 'package:mlplayground/UI/scatter.dart';
import 'package:mlplayground/UI/Regression.dart';
import 'package:mlplayground/provider/Line%20Provider/AlgoProvider.dart';
import 'package:mlplayground/provider/Line%20Provider/lineProvider.dart';
import 'package:provider/provider.dart';

class Linearregression extends StatefulWidget {
  const Linearregression({super.key});

  @override
  State<Linearregression> createState() => _LinearregressionState();
}

class _LinearregressionState extends State<Linearregression> {
  List<double> X = [];
  List<double> Y = [];
  TextEditingController learningrateController = TextEditingController();
  TextEditingController epochController = TextEditingController();
  @override
  initState() {
    super.initState();
    learningrateController.text = 0.01.toString();
    epochController.text = 500.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 216, 167, 176),
        appBar: AppBar(
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            title: RichText(
                text: const TextSpan(
              children: [
                TextSpan(
                  text: 'ML',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Tech",
                      fontSize: 35),
                ),
                TextSpan(
                  text: ' playground',
                  style: TextStyle(
                      color: Colors.blue, fontFamily: "Tech", fontSize: 30),
                ),
              ],
            ))),
        body: Consumer3<lineprovider, regLineProvider, LinReg>(
          builder: (context, value, value2,model, child) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: SelectableText(
                                  "Simple Linear Regression Simulator",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        height: 500,
                        width: 1000,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade900),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              children: [  LineChartSample(), const Line2chart()],
                            ),
                          ),
                        )),
                    Container(
                      child: Text("Correlation of the generated data: ${value.correlation.toStringAsFixed(3)} ",),
                    
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          )),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: 800,
                      child: Ontapexpand(
                          borderRadius: 20,
                          title: 'Advanced Settings',
                          width: 300,
                          color: const Color.fromARGB(255, 216, 167, 176),
                          expandedHeight: 150,
                          collapsedHeight: 50,
                          expandedChild: Container(
                            color: const Color.fromARGB(0, 255, 193, 7),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Learning Rate ( α ): ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 20,
                                              child: Center(
                                                child: TextField(
                                                  onChanged: (value) =>
                                                      setState(() => model.lr
                                                              .learningRate =
                                                          double.parse(value)),
                                                  controller:
                                                      learningrateController,
                                                  cursorHeight: 12,
                                                  cursorColor: Colors.black,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 5,
                                                              vertical: 0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        118,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                width: 1),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        gapPadding: 0.5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        124,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                width: 0.5),
                                                      )),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            )
                                          ])),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Number of Epoches: ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 20,
                                              child: Center(
                                                child: TextField(
                                                  onChanged: (value) =>
                                                      setState(() => model.lr.epoch =
                                                          int.parse(value)),
                                                  controller: epochController,
                                                  cursorHeight: 12,
                                                  cursorColor: Colors.black,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 5,
                                                              vertical: 0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        118,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                width: 1),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        gapPadding: 0.5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        124,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                width: 0.5),
                                                      )),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                            )
                                          ])),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Sample space control", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900),
                            child: TextButton(
                                onPressed: () {
                                  X.clear();
                                  Y.clear();
                                  value.setLine(model.intercept, model.slope, X, Y,
                                      model.sampleSize, model.noise);
                                  value.setScatterSpots();
                                  model.lr.fit(X, Y);
                                  value2.setLine(model.lr.bias, model.lr.weight, X);
                                  model.mse = model.lr.mse(X, Y);
                                  model.rmse =model.lr.rmse(X, Y);
                                  model.r2 = model.lr.r2(X, Y);
                                  model.lr.weightHistory.clear();
                                  model.lr.biasHistory.clear();
                                  print(X);
                                  print(Y);

                                  setState(() {});
                                },
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Populate",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900),
                            child: TextButton(
                                onPressed: () {
                                  X.clear();
                                  Y.clear();
                                  model.intercept = Random().nextInt(10);
                                  model.slope = Random().nextInt(10);
                                  model.sampleSize = Random().nextInt(65) + 5;
                                  model.noise = Random().nextInt(99) + 1;
                                  value.setLine(model.intercept, model.slope, X, Y,
                                  model.sampleSize,model.noise);
                                  value.setScatterSpots();
                                  model.lr.fit(X, Y);
                                  value2.setLine(model.lr.bias, model.lr.weight, X);
                                  model.lr.weightHistory.clear();
                                  model.lr.biasHistory.clear();
                                  model.mse = model.lr.mse(X, Y);
                                  model.rmse = model.lr.rmse(X, Y);
                                  model.r2 = model.lr.r2(X, Y);
                                  print(X);
                                  print(Y);
                                  setState(() {});
                                },
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Randomize",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900),
                            child: TextButton(
                                onPressed: () {
                                  value.reset();
                                  value2.reset();
                                  X.clear();
                                  Y.clear();
                                  model.lr.setBias(0);
                                  model.lr.setWeight(0);
                                  model.slope = 0;
                                  model.intercept = 0;
                                  model.sampleSize = 0;
                                  model.noise = 1;
                                  model.lr.learningRate = 0.0001;
                                  model.lr.epoch = 50000;
                                  learningrateController.text =
                                      model.lr.learningRate.toString();
                                  epochController.text = model.lr.epoch.toString();
                                  model.mse = 0;
                                  model.rmse = 0;
                                  model.r2 = 0;
                                  setState(() {});
                                },
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Reset",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          children: [
                            Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Intercept: " + model.intercept.toString()),
                                  Slider(
                                    value: model.intercept * 1.0,
                                    onChanged: (value) {
                                      setState(() {
                                         model.setIntercept(value.toInt());
                                      });
                                    },
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Slope: " + model.slope.toString()),
                                  Slider(
                                    value: model.slope * 1.0,
                                    onChanged: (value) {
                                      setState(() {
                                        model.setSlope((value.toInt()));
                                      });
                                    },
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Sample Size: " + model.sampleSize.toString()),
                                  Slider(
                                    value: model.sampleSize * 1.0,
                                    onChanged: (value) {
                                      setState(() {
                                        model.setSampleSize(value.toInt());
                                      });
                                    },
                                    min: 0,
                                    max: 70,
                                    divisions: 7,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Noise: " + model.noise.toString()),
                                  Slider(
                                    value: model.noise * 1.0,
                                    onChanged: (value) {
                                      setState(() {
                                        model.setNoise(value.toInt());
                                      });
                                    },
                                    min: 1,
                                    max: 100,
                                    divisions: 20,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SelectableText(
                              "Estimated function: Y = ${model.lr.bias.toStringAsFixed(6)} + ${model.lr.weight.toStringAsFixed(6)} * X  \n Calculated intercept( theta0 ): ${model.lr.bias.toStringAsFixed(6)} \n Calculated slope( theta1 ): ${model.lr.weight.toStringAsFixed(6)}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Metrices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 50),
                      child: Table(
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 0.5,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          children: [
                            const TableRow(
                                children: [
                                  Center(
                                      child: Text(
                                    "MSE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "RMSE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "R2",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "Accuracy",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),

                                ],
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(
                                        255, 244, 163, 163))),
                            TableRow(children: [
                              Center(
                                  child: SelectableText(
                                model.mse.toStringAsFixed(5),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )),
                              Center(
                                  child: SelectableText(
                                model.rmse.toStringAsFixed(5),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )),
                              Center(
                                  child: SelectableText(
                                model.r2.toStringAsFixed(5),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )),
                              const Center(
                                  child: SelectableText(
                               "-",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )),

                            ])
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 0.5,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: Text("How does Linear Regression work? 🧠", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: const SelectableText("Simple regression is a statistical method used to model the relationship between a single independent variable (predictor) and a dependent variable (outcome) by fitting a straight line to the data. The goal is to find the line (using the equation \( y = mx + b \)) that minimizes the error between predicted and actual values. This is achieved through gradient descent, an optimization algorithm that iteratively adjusts the slope (\( m \)) and intercept (\( b \)) to minimize the loss function (e.g., mean squared error). As gradient descent progresses, it moves closer to the optimal values until convergence, where the loss stops decreasing.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: const SelectableText("The loss function used here is the sum of squared errors between the predicted values and the actual values. Its is also called the MSE (Mean Squared Error). The equation for finding the MSE is given Below:\n ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: const Center(child: SelectableText("J( θ0 , θ1 ) = 1/n * Σ((hθ(x) - y)^2)", style: TextStyle(backgroundColor: Color.fromARGB(
                                        255, 244, 163, 163), fontSize: 25, fontWeight: FontWeight.bold),)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: const SelectableText("Where hθ(x) is the predicted value of y for a given input x, θ0 and θ1 are the intercept and slope of the regression line, and n is the sample size.\ni.e. hθ(x) = θ0 + θ1 * x", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: SelectableText('''The minimization the MSE loss function is achieved through gradient descent, which iteratively adjusts the values of θ0 and θ1 to minimize the loss function. ''', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                    ),
Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SelectableText("For more on gradient descent, click ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                          TextButton(onPressed: (){
                            GoRouter.of(context).go('/gradient-descent-simulator');
                          }, child: const Text('Gradient Descent'))
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                          child: Text(
                        "Made with ❤️ & Flutter by Arjak",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    )
                  ],
                ),
              )),
        ));
  }
}
