import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class BiblioStatsPiso5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Stats Biblio Piso 1',
      debugShowCheckedModeBanner: false,
      home: StatsPage(),
    );
  }
}

class StatsPage extends StatefulWidget {
  @override
  StatsPageState createState() => new StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[

        ],
      ),
    );
  }
}