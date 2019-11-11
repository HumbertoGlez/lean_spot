import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:lean_spot/BiblioStatsPiso2.dart';
import 'package:lean_spot/BiblioStatsPiso3.dart';
import 'package:lean_spot/BiblioStatsPiso4.dart';
import 'package:lean_spot/BiblioStatsPiso5.dart';

/// Main screen for BiblioTec, here the user can choose what floor to check
class BiblioTec extends StatelessWidget {
  final String name;
  final Color mainColor;

  BiblioTec({
    this.name,
    this.mainColor
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'BiblioTec',
      debugShowCheckedModeBanner: false,
      home: BiblioPage(),
    );
  }
}

class BiblioPage extends StatefulWidget {
  @override
  BiblioPageState createState() => new BiblioPageState();
}

class BiblioPageState extends State<BiblioPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        backgroundColor: Colors.blue[50],
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  roundCards('images/BiblioPiso2.jpg', 'Piso 2', BiblioStatsPiso2()),
                  roundCards('images/BiblioPiso3.jpg', 'Piso 3', BiblioStatsPiso3())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  roundCards('images/BiblioPiso4.jpg', 'Piso 4', BiblioStatsPiso4()),
                  roundCards('images/BiblioPiso5.jpg', 'Piso 5', BiblioStatsPiso5())
                ],
              ),
            ],
          )
        ]
      )
    );
  }

  Widget roundCards(String url, String about, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 30),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.6,
                  color: Colors.white,
                )
              ],
              border: Border.all(width: 10, color: Colors.grey[200]),
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.transparent),
          child: Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 240,
                decoration: BoxDecoration(
  //                color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(url)
                  )
                )
              ),
              Container(
                  margin: EdgeInsets.only(left: 0, top: 180),
                  color: Color(0x40000000),
                  width: 150,
                  child: Text(
                      ' ' + about,
                      style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 40,
                        color: Colors.white
                      ),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}

