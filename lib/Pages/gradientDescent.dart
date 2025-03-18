import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mlplayground/UI/Gradient-Descent/best-fit-lines.dart';
import 'package:mlplayground/UI/Gradient-Descent/convTheta0.dart';
import 'package:mlplayground/UI/Gradient-Descent/convTheta1.dart';
import 'package:mlplayground/UI/Gradient-Descent/loss-function-plot.dart';
import 'package:mlplayground/UI/Gradient-Descent/scatter.dart';
import 'package:mlplayground/UI/card-conatiner.dart';
import 'package:mlplayground/UI/ontapExpand.dart';
import 'package:mlplayground/provider/Gradient-Descent/GDfit-provider.dart';
import 'package:mlplayground/provider/Gradient-Descent/Reg-line-provider.dart';
import 'package:mlplayground/provider/Gradient-Descent/sample-data.dart';
import 'package:provider/provider.dart';

class Gradientdescent extends StatefulWidget {
  const Gradientdescent({super.key});

  @override
  State<Gradientdescent> createState() => _GradientdescentState();
}

class _GradientdescentState extends State<Gradientdescent> {
  bool isFitting = false;
  TextEditingController learningrateController = TextEditingController();
  TextEditingController epochController = TextEditingController();

  void _showInstructionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.info,
            color: Color.fromARGB(255, 48, 48, 48),
          ),
          title: const Text("How to Use the Simulator"),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text("Step 1",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                height: 300,
                width: 300,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 0.5,
                )),
                child: Image.asset(
                  alignment: const Alignment(-0.5, 0),
                  fit: BoxFit.cover,
                  'assets/Randomize.gif',
                ),
              ),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Tap on Randomize. A sample data for linear regression would be populated.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    ),
                  )),
              const Text("Step 2",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                height: 300,
                width: 300,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 0.5,
                )),
                child: Image.asset(
                  height: 300,
                  width: 300,
                  'assets/fit.gif',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Tap on Fit. The model will be fitted to the data.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    ),
                  )),
              const Text("Step 3",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                height: 300,
                width: 300,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 0.5,
                )),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/reset.png',
                ),
              ),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Tap on reset to start over.",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    ),
                  )),
              const Text("Advanced Settings",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "You can change the learning rate and number of epochs",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                    ),
                  )),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Got it"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    learningrateController.text = '0.001';
    epochController.text = '10000';
    super.initState();
    Future.delayed(Duration.zero, () => _showInstructionsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 239, 255),
        appBar: AppBar(
            actions: [
              IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    _showInstructionsDialog();
                  })
            ],
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            title: RichText(
                text: const TextSpan(children: [
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
            ]))),
        body: Consumer3<sampleData, Gdfitprovider, Reglinesprovider>(
          builder: (context, sample, model, reglines, child) =>
              SingleChildScrollView(
            child: (MediaQuery.of(context).size.width > 1000)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      card(
                          title: "Gradient Descent",
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          height: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 0.5,
                                              )),
                                          child: Container(
                                              margin: const EdgeInsets.all(20),
                                              height: 500,
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade900),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.all(20.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Stack(
                                                    children: [
                                                      scatter(),
                                                      bestfitlines()
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        const Text("Best fit lines")
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          height: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 0.5,
                                              )),
                                          child: Container(
                                              margin: const EdgeInsets.all(20),
                                              height: 500,
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade900),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.all(20.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Stack(
                                                    children: [convTheta0()],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        const Text("Convergence of theta0")
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          height: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 0.5,
                                              )),
                                          child: Container(
                                              margin: const EdgeInsets.all(20),
                                              height: 500,
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade900),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.all(20.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Stack(
                                                    children: [convTheta1()],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        const Text(
                                          "Convergence of theta1",
                                        )
                                      ],
                                    ),
                                  ),
                                ],
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
                            color: const Color.fromARGB(255, 224, 239, 255),
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
                                                    onChanged: (value) => {
                                                      model.setLearningRate(
                                                          double.parse(value)),
                                                    },
                                                    // setState(() => model.lr
                                                    //         .learningRate =
                                                    //     double.parse(value)),
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
                                              const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child:  Text(
                                                    "Number of Epoches (⚠️ may take a longer time for large epoches): ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                height: 20,
                                                child: Center(
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      model.setEpoch(
                                                          int.parse(value));
                                                    },
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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Correlation of sample data : ${sample.corr.toStringAsFixed(3)}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),

                              SizedBox(
                                height: 10,
                                width: 20,
                              ),

                              Text("Epoch : ${model.epochNow}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      card(
                          title: "Controls",
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 1,
                                )),
                            child: Flex(
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
                                          double intercept =
                                              Random().nextInt(10).toDouble();
                                          double slope =
                                              Random().nextInt(10).toDouble();
                                          double noise = 100;
                                          sample.setSampledataparms(
                                              intercept, slope, noise, 30);
                                          sample.populate();
                                          reglines.reset();
                                          model.reset();
                                        },
                                        child: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "Randomize",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          isFitting = !isFitting;
                                          await model.fit(sample.X, sample.Y);
                                          isFitting = !isFitting;
                                        },
                                        icon: (isFitting)
                                            ? CircularProgressIndicator(
                                                color: Colors.grey.shade900,
                                              )
                                            : const Icon(Icons.play_arrow_sharp),
                                        iconSize: 50,
                                        color: Colors.black,
                                      ),
                                    ],
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
                                          sample.reset();
                                          reglines.reset();
                                          model.reset();
                                        },
                                        child: const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "Reset",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      card(
                          title: "Loss Function",
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 1,
                                )),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade900),
                                height: 250,
                                child: const lossConvergence(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "loss function v/s epochs",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ]),
                          )),
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
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Gradient Descent",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InteractiveViewer(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 1,
                                )),
                            child: Flex(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade900),
                                          margin: const EdgeInsets.all(10),
                                          height: 300,
                                          width: 300,
                                          child: const Stack(
                                            children: [scatter(), bestfitlines()],
                                          ),
                                        ),
                                        const Text(
                                          "Best fit lines",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade900),
                                          height: 300,
                                          width: 300,
                                          child: const Stack(
                                            children: [convTheta0()],
                                          ),
                                        ),
                                        const Text(
                                          "Convergence of theta0",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade900),
                                          height: 300,
                                          width: 300,
                                          child: const Stack(
                                            children: [convTheta1()],
                                          ),
                                        ),
                                        const Text(
                                          "Convergence of theta1",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Correlation of sample data : ${sample.corr.toStringAsFixed(3)}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),

                              SizedBox(
                                height: 10,
                                width: 20,
                              ),

                              Text("Epoch : ${model.epochNow}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        card(
                            title: "Controls",
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  )),
                              child: Flex(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade900),
                                      child: TextButton(
                                          onPressed: () {
                                            double intercept =
                                                Random().nextInt(10).toDouble();
                                            double slope =
                                                Random().nextInt(10).toDouble();
                                            double noise = 100;
                                            sample.setSampledataparms(
                                                intercept, slope, noise, 30);
                                            sample.populate();
                                            reglines.reset();
                                            model.reset();
                                          },
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "Randomize",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            isFitting = !isFitting;
                                            await model.fit(sample.X, sample.Y);
                                            isFitting = !isFitting;
                                          },
                                          icon: (isFitting)
                                              ? CircularProgressIndicator(
                                                  color: Colors.grey.shade900,
                                                )
                                              : const Icon(
                                                  Icons.play_arrow_sharp),
                                          iconSize: 50,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade900),
                                      child: TextButton(
                                          onPressed: () {
                                            sample.reset();
                                            reglines.reset();
                                            model.reset();
                                          },
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              "Reset",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
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
                              color: const Color.fromARGB(255, 224, 239, 255),
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
                                                      onChanged: (value) => {
                                                        model.setLearningRate(
                                                            double.parse(
                                                                value)),
                                                      },
                                                      // setState(() => model.lr
                                                      //         .learningRate =
                                                      //     double.parse(value)),
                                                      controller:
                                                          learningrateController,
                                                      cursorHeight: 12,
                                                      cursorColor: Colors.black,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          0),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: const BorderSide(
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
                                                                        .circular(
                                                                            2),
                                                                borderSide: const BorderSide(
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
                                      Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Number of Epochs: ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Container(
                                                  width: 100,
                                                  height: 20,
                                                  child: Center(
                                                    child: TextField(
                                                      onChanged: (value) {
                                                        model.setEpoch(
                                                            int.parse(value));
                                                      },
                                                      controller:
                                                          epochController,
                                                      cursorHeight: 12,
                                                      cursorColor: Colors.black,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                      decoration:
                                                          InputDecoration(
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          0),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                borderSide: const BorderSide(
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
                                                                        .circular(
                                                                            2),
                                                                borderSide: const BorderSide(
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
                        card(
                            title: "Loss Function",
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  )),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade900),
                                  height: 250,
                                  child: const lossConvergence(),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "loss function v/s epochs",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ]),
                            )),
                        Container(
                          color: Colors.black,
                          height: 0.5,
                          margin: const EdgeInsets.all(10.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10.0),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Text(
                                  "What is Gradient Descent?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                SelectableText('''Gradient descent is an optimization algorithm used to minimize a loss function by iteratively adjusting parameters in the direction of its steepest descent. It computes the gradient (partial derivative) of the loss function with respect to each parameter, which indicates the direction and rate of the steepest increase. By subtracting the gradient scaled by a learning rate from each parameter, the algorithm converges toward an optimal set of parameters.
                                      '''),
                                SelectableText(
                                  '''Here we are using the gradient descent algorithm to fit a best fit line for the given data.
                                  ''',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ]),
                        ),
// FittedBox(
//   fit: BoxFit.fitWidth,  
//   child: Center(
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text('Learning Rate')),
//             DataColumn(label: Text('Epochs')),
//             DataColumn(label: Text('Purpose/Observation')),
//           ],
//           rows: [
//             DataRow(cells: [
//               DataCell(Text('0.01')),
//               DataCell(Text('50')),
//               DataCell(Text('Basic training, observe steady cost decrease.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.1')),
//               DataCell(Text('100')),
//               DataCell(Text('Faster convergence, but watch for oscillations.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.001')),
//               DataCell(Text('500')),
//               DataCell(Text('Slower convergence, but more stable.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.0001')),
//               DataCell(Text('1000')),
//               DataCell(Text('Very slow, observe precise gradual cost reduction.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.05')),
//               DataCell(Text('200')),
//               DataCell(Text('Moderate learning rate with balanced epochs.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.2')),
//               DataCell(Text('30')),
//               DataCell(Text('Potential overstepping, see how it affects cost.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.5')),
//               DataCell(Text('20')),
//               DataCell(Text('Overly aggressive—observe if divergence occurs.')),
//             ]),
//             DataRow(cells: [
//               DataCell(Text('0.005')),
//               DataCell(Text('300')),
//               DataCell(Text('Safe and balanced for smoother convergence.')),
//             ]),
//           ],
//         ),
//       ),
// )
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
                  ),
                  
          ),
        ));
  }
}
