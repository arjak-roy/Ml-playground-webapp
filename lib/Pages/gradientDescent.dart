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
  TextEditingController learningrateController = TextEditingController();
  TextEditingController epochController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    learningrateController.text = '0.001';
    epochController.text = '20000';
    super.initState();
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 239, 255),
        appBar: AppBar(
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
                                          margin: EdgeInsets.all(10.0),
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
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
                                        Text("Best fit lines")
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
                                          margin: EdgeInsets.all(10.0),
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Stack(
                                                    children: [convTheta0()],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Text("Convergence of theta0")
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
                                          margin: EdgeInsets.all(10.0),
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: Stack(
                                                    children: [convTheta1()],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Text("Convergence of theta1")
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
                          color: const  Color.fromARGB(255, 224, 239, 255),
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
                                                  onChanged: (value) =>{
                                                    model.setLearningRate(double.parse(value)),
                                                  },
                                                      // setState(() => model.lr
                                                      //         .learningRate =
                                                      //     double.parse(value)),
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
                                                  onChanged: (value) {
                                                    model.setEpoch(int.parse(value));
                                                  },
                                                   
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
                      Center(
                        child: Text("Epoch : ${model.epochNow}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20)),
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
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: const Text(
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
                                          await model.fit(sample.X, sample.Y);
                                        },
                                        icon: Icon(Icons.play_arrow_sharp),
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
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: const Text(
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
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade900),
                                        height: 250,
                                      child: lossConvergence(),
                                      ),
                                      Text(
                                        "loss function v/s epochs",
                                        style: TextStyle(color: Colors.black),
                                      )
                                  ]),
                            ) )

                    ],
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Gradient Descent", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade900),
                                        margin: const EdgeInsets.all(10),
                                        height: 250,
                                        width: 250,
                                        child: Stack(
                                          children: [scatter(), bestfitlines()],
                                        ),
                                      ),
                                      Text(
                                        "Best fit lines",
                                        style: TextStyle(color: Colors.black),
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
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade900),
                                        height: 250,
                                        width: 250,
                                        child: Stack(
                                          children: [convTheta0()],
                                        ),
                                      ),
                                      Text(
                                        "Convergence of theta0",
                                        style: TextStyle(color: Colors.black),
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
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade900),
                                        height: 250,
                                        width: 250,
                                        child: Stack(
                                          children: [convTheta1()],
                                        ),
                                      ),
                                      Text(
                                        "Convergence of theta1",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Center(
                        child: Text("Epoch : ${model.epochNow}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                                )),
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
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: const Text(
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
                                          await model.fit(sample.X, sample.Y);
                                        },
                                        icon: Icon(Icons.play_arrow_sharp),
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
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: const Text(
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
                          color: const  Color.fromARGB(255, 224, 239, 255),
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
                                                  onChanged: (value) =>{
                                                    model.setLearningRate(double.parse(value)),
                                                  },
                                                      // setState(() => model.lr
                                                      //         .learningRate =
                                                      //     double.parse(value)),
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
                                                  onChanged: (value) {
                                                    model.setEpoch(int.parse(value));
                                                  },
                                                   
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
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade900),
                                        height: 250,
                                      child: lossConvergence(),
                                      ),
                                      Text(
                                        "loss function v/s epochs",
                                        style: TextStyle(color: Colors.black),
                                      )
                                  ]),
                            ) )
                      ],
                    ),
                  ),
          ),
        ));
  }
}
