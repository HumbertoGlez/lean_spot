import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'homePage.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool isOpen = false;
  int duration;

  @override
  void initState() {
    super.initState();
    duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
    Future.delayed(Duration(milliseconds: 10)).then((value) {
      setState(() {
        isOpen = true;
      });
    });
    setDelay().then((value) {
      onDoneLoading();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  Future setDelay() async {
    await Future.delayed(Duration(milliseconds: duration));
  }

   void onDoneLoading()  async {
     var page = await buildPageAsync();
     var route = CupertinoPageRoute(builder: (context) => page, fullscreenDialog: true);
     Navigator.pushReplacement(context, route);
   }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/biblioOutside.jpg"), context);
    precacheImage(AssetImage("images/BiblioPiso2.jpg"), context);
    precacheImage(AssetImage("images/BiblioPiso3.jpg"), context);
    precacheImage(AssetImage("images/BiblioPiso4.jpg"), context);
    precacheImage(AssetImage("images/BiblioPiso5.jpg"), context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedDefaultTextStyle(
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 1000),
                  child: Text('Lean Spot'),
                  style: isOpen
                  ? TextStyle(
                      fontFamily: 'Silent Reaction',
                      color: Colors.white,
                      fontSize: 65
                  )
                  : TextStyle(
                      fontFamily: 'Silent Reaction',
                      color: Colors.white,
                      fontSize: 10
                  )
              ),
              /// Loader Animation Widget
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.white),
              ),
            ],
          )
        )
      )
    );
  }
}

Future<Widget> buildPageAsync() async {
  return Future.microtask(() {
    return MyHomePage();
  });
}