import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Widget backgroundImg;

  LoadingScreen(this.backgroundImg);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Stack(
        children: <Widget>[
          Center(
            child: backgroundImg
          ),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Lean Spot',
                      style: TextStyle(
                        fontFamily: 'Silent Reaction',
                        color: Colors.white,
                        fontSize: 50,
                      )
                  ),
                  /// Loader Animation Widget
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Text('Obteniendo datos', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              )
          )
        ],
      ),
    );
  }
}