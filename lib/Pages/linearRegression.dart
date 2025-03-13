import 'dart:math';
import 'package:flutter/material.dart';
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
  // int intercept = 0;
  // int slope = 0;
  // int sampleSize = 0;
  // int noise = 1;
  TextEditingController learningrateController = TextEditingController();
  TextEditingController epochController = TextEditingController();
  // LinearRegression lr = LinearRegression(epoch: 50000, learningRate: 0.0001);
  // double mse = 0;
  // double r2 = 0;
  // double rmse = 0;

  @override
  initState() {
    super.initState();
    learningrateController.text = 0.0001.toString();
    epochController.text = 50000.toString();
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
                              children: [  LineChartSample(), Line2chart()],
                            ),
                          ),
                        )),
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
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
                                                  style: TextStyle(
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
                                            Text(
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
                                                  style: TextStyle(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text("Sample space control", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: const Text(
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
                                  model.noise = Random().nextInt(9) + 1;

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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: const Text(
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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: const Text(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text("Metrices", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 50),
                      child: Table(
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 0.5,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          children: [
                            TableRow(
                                children: [
                                  Center(
                                      child: Text(
                                    "MSE",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "RMSE",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "R2",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Center(
                                      child: Text(
                                    "Accuracy",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),

                                ],
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
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
                              Center(
                                  child: SelectableText(
                               "-",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )),

                            ])
                          ]),
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
