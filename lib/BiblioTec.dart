import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:lean_spot/StatsScreen.dart';

/// Main screen for BiblioTec, here the user can choose what floor to check
class BiblioTec extends StatefulWidget {
  @override
  BiblioTecState createState() => new BiblioTecState();
}

class BiblioTecState extends State<BiblioTec> {
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
              Padding(padding: EdgeInsets.only(top: 30),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  roundCards('images/BiblioPiso2.jpg', 'Piso 2',
                      StatsScreen(
                        lugar:'Piso 2',
                        backgroundImage: new Image.asset(
                          'images/biblioOutside.jpg',
                          fit: BoxFit.cover,
                          height: 800,
                          color: Colors.blue[900],
                          colorBlendMode: BlendMode.multiply,
                        ),
                        queryHoras: 'SELECT HOUR(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 5 HOUR)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime) LIMIT 6',
                        queryRealTime: 'SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND MINUTE(pushTime) >= MINUTE(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 5',
                      )
                  ),
                  roundCards('images/BiblioPiso3.jpg', 'Piso 3',
                      StatsScreen(
                        lugar:'Piso 3',
                        backgroundImage: new Image.asset(
                          'images/biblioOutside.jpg',
                          fit: BoxFit.cover,
                          height: 800,
                          color: Colors.blue[900],
                          colorBlendMode: BlendMode.multiply,
                        ),
                        queryHoras: 'SELECT HOUR(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 5 HOUR)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime) LIMIT 6',
                        queryRealTime: 'SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND MINUTE(pushTime) >= MINUTE(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 5',
                      )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  roundCards('images/BiblioPiso4.jpg', 'Piso 4',
                      StatsScreen(
                        lugar:'Piso 4',
                        backgroundImage: new Image.asset(
                          'images/biblioOutside.jpg',
                          fit: BoxFit.cover,
                          height: 800,
                          color: Colors.blue[900],
                          colorBlendMode: BlendMode.multiply,
                        ),
                        queryHoras: 'SELECT HOUR(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 5 HOUR)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime) LIMIT 6',
                        queryRealTime: 'SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND MINUTE(pushTime) >= MINUTE(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 5',
                      )
                  ),
                  roundCards('images/BiblioPiso5.jpg', 'Piso 5',
                      StatsScreen(
                        lugar:'Piso 5',
                        backgroundImage: new Image.asset(
                          'images/biblioOutside.jpg',
                          fit: BoxFit.cover,
                          height: 800,
                          color: Colors.blue[900],
                          colorBlendMode: BlendMode.multiply,
                        ),
                        queryHoras: 'SELECT HOUR(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 5 HOUR)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime) LIMIT 6',
                        queryRealTime: 'SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND MINUTE(pushTime) >= MINUTE(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 5',
                      )
                  )
                ],
              ),
            ],
          )
        ]
      )
    );
  }

  Widget roundCards(String imageUrl, String about, Widget page) {
    return InkWell(
      /// ESTA FUNCIÓN ES LA QUE DETECTA EL INPUT DEL USUARIO
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => page),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 30),
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
                    image: AssetImage(imageUrl)
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

