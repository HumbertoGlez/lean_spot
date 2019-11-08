import 'package:flutter/material.dart';

class BiblioTec extends StatelessWidget {
  final String name;
  final Color mainColor;

  BiblioTec({
    this.name,
    this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: Center(
        child: Text("Screen 1",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
    );
  }
}