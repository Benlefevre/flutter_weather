import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDeco extends StatelessWidget {
  final Alignment start;
  final Alignment end;
  final List<Color> colors;
  static const List<Color> defaultColors = [Colors.blueAccent,Colors.black87];
  final Widget child;
  final double radius;

  TextDeco(this.child,
      {this.start = Alignment.topLeft,
      this.end = Alignment.bottomRight,
      this.colors = defaultColors,
      this.radius = 50.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: start,
            end: end,
            colors: colors),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
