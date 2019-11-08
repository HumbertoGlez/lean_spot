import 'package:flutter/material.dart';

class Centrales extends StatelessWidget {
  final String name;
  final Color mainColor;

  Centrales({
    this.name,
    this.mainColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: Center(
        child: Text("Screen 2",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
    );
  }
}