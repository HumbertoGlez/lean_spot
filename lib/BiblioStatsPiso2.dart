import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mysql1/mysql1.dart' as mysql;
import 'dart:async';
import 'dart:io';


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
  List<int> _horas = List<int>();
  List<int> _valores = List<int>();
  Future _callData() async{
    // Open a connection (testdb should already exist)
    final connection = await mysql.MySqlConnection.connect(new mysql.ConnectionSettings(
        host: '35.188.61.105',
        port: 3306,
        user: 'root',
        password: 'PJKDp7lFjA1jxyn0',
        db: 'EMPLEATEC',
        ));
    var results = await connection.query('SELECT * FROM Conteo Limit 6');

    for (var row in results) {
      _valores.add(row[0]);
      _horas.add(row[0]);
    }

    // Finally, close the connection
    await connection.close();
    return [_horas, _valores];
  }



  @override
  void initState(){
    super.initState();
    _callData().then((data) {
      setState(() {
        this._horas= data[0];
        this._valores = data[1];
      });
    });
  }
  @override
  Widget build(BuildContext context){
    /// SET UP THE GRAPH
    var data = [
      new DevicesPerHour(_horas[0], _valores[0], Colors.red),
      new DevicesPerHour(_horas[1], _valores[1], Colors.blue),
      new DevicesPerHour(_horas[2], _valores[2], Colors.green),
      new DevicesPerHour(_horas[3], _valores[3], Colors.purple),
      new DevicesPerHour(_horas[4], _valores[4], Colors.orange),
      new DevicesPerHour(_horas[5], _valores[5], Colors.pink),
    ];
    var series = [
      new charts.Series<DevicesPerHour, int>(
        id: 'Hora',
        domainFn: ((DevicesPerHour fluxData, _) => fluxData.hour),
        measureFn: (DevicesPerHour fluxData, _) => fluxData.devices,
        colorFn: (DevicesPerHour fluxData, _) => fluxData.color,
        areaColorFn: (DevicesPerHour fluxData, _) => fluxData.color.lighter,
        data: data,
      ),
    ];


    var chart = new charts.LineChart(
      series,
      defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: true,
      behaviors: [
        new charts.ChartTitle("Horas",
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Ocupación',
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
      ],
    );

    /// WIDGETS FOR THIS SCREEN
    Widget mainStatus() {
      return Container(
          margin: EdgeInsets.only(right: 20),
          child: Text(
            "Lleno",
            style: TextStyle(
              fontFamily: 'Bebas',
              fontSize: 60,
              color: Colors.red,
            ),
          )
      );
    }

    Widget graph() {
      return Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Container(
            height: 250,
            width: 370,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.6,
                    color: Colors.grey[200],
                  )
                ],
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.transparent),
            child: Padding(
              padding: new EdgeInsets.all(10),
              child: new SizedBox(
                height: 200,
                child: chart,
              ),
            ),
          )
      );
    }

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
                  graph()
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
}

class DevicesPerHour{
  final int hour;
  final int devices;
  final charts.Color color;

  DevicesPerHour(this.hour, this.devices, Color color)
    : this.color = new charts.Color(
    r: color.red, g: color.green, b: color.blue, a: color.alpha);
}