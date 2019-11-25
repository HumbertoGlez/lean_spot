import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lean_spot/StatsScreen.dart';

class Centrales extends StatefulWidget {
  @override
  CentralesState createState() => new CentralesState();
}

class CentralesState extends State<Centrales> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
            children: <Widget>[
              Center(
                child: new Image.asset(
                  'images/centrales.jpg',
                  fit: BoxFit.cover,
                  height: 800,
                  color: Colors.orange[900],
                  colorBlendMode: BlendMode.multiply,
                ),
              ),
              ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      roundCards('images/centrales2.jpg', 'Centrales',
                          StatsScreen(
                            lugar:'Centrales',
                            backgroundImage: new Image.asset(
                              'images/centrales.jpg',
                              fit: BoxFit.cover,
                              height: 800,
                              color: Colors.orange[900],
                              colorBlendMode: BlendMode.multiply,
                            ),
                            queryHoras: 'SELECT HOUR(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 5 HOUR)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime) LIMIT 6',
                            queryRealTime: 'SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo WHERE HOUR(pushTime) >= HOUR(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND MINUTE(pushTime) >= MINUTE(DATE_SUB(NOW(), INTERVAL 6 MINUTE)) AND DAY(pushTime) = 4 AND MONTH(pushTime) = 10 GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 5',
                          )
                      ),
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
            height: 300,
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
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
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

