import 'package:flutter/material.dart';

class Ontapexpand extends StatefulWidget {
  final String title;
  final Widget expandedChild;
  final double width;
  final Color color;
  final double ?borderRadius;
  final Duration ?duration;
  final double expandedHeight;
  final double collapsedHeight;
  
  const Ontapexpand({super.key, required this.title, required this.width, required this.color,  this.borderRadius,  this.duration, required this.expandedHeight, required this.collapsedHeight, required this.expandedChild});

  @override
  State<Ontapexpand> createState() => _OntapexpandState();
}

class _OntapexpandState extends State<Ontapexpand> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      height: isExpanded ? widget.expandedHeight : widget.collapsedHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),color: widget.color,),
      child:  Container(
        width: widget.width,
        child: Flex(
          direction: Axis.vertical,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15, fontWeight: FontWeight.w600),),
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: const Color.fromARGB(255, 0, 0, 0),)
                ],
              ),
            ),
            Flexible(child: isExpanded ? widget.expandedChild : Container(),
)
          ],
        ),
      ),
      );
  }
}