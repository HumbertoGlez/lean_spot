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
//      color: mainColor,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        image: DecorationImage(
          image: AssetImage('images/biblioOutside.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.5), BlendMode.dstATop),
        )
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkResponse(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      new BoxShadow(
                          color: Colors.black,
                          offset: new Offset(15, 20.0),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/BiblioPiso2.jpg'),
                            width: MediaQuery.of(context).size.width * .45,
                          ),
                          Container(
                            width: 185,
                            margin: EdgeInsets.only(top: 70),
                            color: Color(0x40000000),
                            child:  Text(
                              ' Piso 2',
                              style: TextStyle(
                                fontFamily: 'Bebas',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                InkResponse(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(15, 20.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    ),
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/BiblioPiso4.jpg'),
                            width: MediaQuery.of(context).size.width * .45,
                          ),
                          Container(
                            width: 185,
                            margin: EdgeInsets.only(top: 70),
                            color: Color(0x40000000),
                            child:  Text(
                              ' Piso 4',
                              style: TextStyle(
                                fontFamily: 'Bebas',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                InkResponse(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(15, 20.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    ),
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/BiblioPiso3.jpg'),
                            width: MediaQuery.of(context).size.width * .45,
                          ),
                          Container(
                            width: 185,
                            margin: EdgeInsets.only(top: 70),
                            color: Color(0x40000000),
                            child:  Text(
                              ' Piso 3',
                              style: TextStyle(
                                fontFamily: 'Bebas',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                InkResponse(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(15, 20.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    ),
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/BiblioPiso5.jpg'),
                            width: MediaQuery.of(context).size.width * .45,
                          ),
                          Container(
                            width: 185,
                            margin: EdgeInsets.only(top: 70),
                            color: Color(0x40000000),
                            child:  Text(
                              ' Piso 5',
                              style: TextStyle(
                                fontFamily: 'Bebas',
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}