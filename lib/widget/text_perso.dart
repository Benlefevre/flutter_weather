import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextPerso extends StatelessWidget{

  final String data;
  final Color color;
  final double fontSize;
  final TextAlign align;

  TextPerso(this.data, {this.color = Colors.white, this.fontSize = 16.0, this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
      textAlign: align,
    );
  }

}