import 'package:flutter/material.dart';

class card extends StatefulWidget {
  final Widget child;
  final Color ?color;
  final String ?title;
  const card({super.key, required this.child, this.color, this.title});

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
        color: widget.color ?? Colors.transparent,
         width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.title ?? "", style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20,fontWeight: FontWeight.w600),),
          ),
          widget.child
        ],
      ),
      );
    
  }
}