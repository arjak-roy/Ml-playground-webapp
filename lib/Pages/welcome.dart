import 'package:flutter/material.dart';

class welocomePage extends StatefulWidget {
  const welocomePage({super.key});

  @override
  State<welocomePage> createState() => _welocomePageState();
}

class _welocomePageState extends State<welocomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome"),),
    );
  }
}