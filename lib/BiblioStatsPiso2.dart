import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class BiblioStatsPiso2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Stats Biblio Piso 2',
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
          Center(
            child: new Image.asset(
              'images/biblioOutside.jpg',
              fit: BoxFit.cover,
              height: 800,
              color: Colors.blue[900],
              colorBlendMode: BlendMode.multiply,
            ),
          ),
          ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Piso 2:',
                      style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 60,
                        color: Colors.white
                      ),
                    )
                  ),
                  mainStatus()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
//                  graph()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
//                  recommendations()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget mainStatus() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Text(
        'Lleno',
        style: TextStyle(
          fontFamily: 'Bebas',
          fontSize: 60,
          color: Colors.red,
        ),
      )
    );
  }
}