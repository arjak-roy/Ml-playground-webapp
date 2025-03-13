import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buttn extends StatefulWidget {
  final String text;
  final Color color;
  const buttn({super.key, required this.text, required this.color});

  @override
  State<buttn> createState() => _buttnState();
}

class _buttnState extends State<buttn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      } ,
      splashColor: Colors.black38,
      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromARGB(255, 111, 111, 111),
                            width: 3,
                          )
                          
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              widget.text,
                              style: GoogleFonts.pixelifySans(
                                fontSize: 50,
                                color: widget.color,
                                shadows: [
                                  Shadow(
                                    color: const Color.fromARGB(122, 255, 255, 255),
                                    offset: Offset(0, 0),
                                    blurRadius: 10
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
    );
  }
}