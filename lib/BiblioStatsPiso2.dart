// UI Controller Bibliotec Piso 2

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mysql1/mysql1.dart' as mysql;
import 'dart:async';
import 'dart:io';
import 'loadingScreen.dart';

class BiblioStatsPiso2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatsPage();
  }
}

class StatsPage extends StatefulWidget {
  @override
  StatsPageState createState() => new StatsPageState();
}


class StatsPageState extends State<StatsPage> {
  List<int> _horas = List<int>();
  List<int> _valores = List<int>();
  var data, series;
  //
  Future _callData() async{
    // Open a connection (testdb should already exist)
    final connection = await mysql.MySqlConnection.connect(new mysql.ConnectionSettings(
        host: '35.188.61.105',
        port: 3306,
        user: 'root',
        password: 'PJKDp7lFjA1jxyn0',
        db: 'EMPLEATEC',
        ));
    var results = await connection.query('SELECT HOUR(pushTime), MINUTE(pushTime), COUNT(distinct(mac)) FROM EMPLEATEC.Conteo  WHERE pushTime >= DATE_SUB(NOW(), INTERVAL 6 MINUTE) GROUP BY HOUR(pushTime), MINUTE(pushTime) LIMIT 6');
    print(results);
    for (var row in results) {
      _valores.add(row[2]);
      _horas.add(row[1]);
    }

    // Finally, close the connection
    await connection.close();
    return [_horas, _valores];
  }

  void setData() {
    data = [
      new DevicesPerHour(_horas[0], _valores[0], Colors.red),
      new DevicesPerHour(_horas[1], _valores[1], Colors.blue),
      new DevicesPerHour(_horas[2], _valores[2], Colors.green),
      new DevicesPerHour(_horas[3], _valores[3], Colors.purple),
      new DevicesPerHour(_horas[4], _valores[4], Colors.orange),
      new DevicesPerHour(_horas[5], _valores[5], Colors.pink),
    ];
    series = [
      new charts.Series<DevicesPerHour, int>(
        id: 'Hora',
        domainFn: ((DevicesPerHour fluxData, _) => fluxData.hour),
        measureFn: (DevicesPerHour fluxData, _) => fluxData.devices,
        colorFn: (DevicesPerHour fluxData, _) => fluxData.color,
        areaColorFn: (DevicesPerHour fluxData, _) => fluxData.color.lighter,
        data: data,
      ),
    ];
  }


  @override
  void initState(){
    super.initState();
    _callData().then((result) {
          setState(() {
            this._horas= result[0];
            this._valores = result[1];
          });
          setData();
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => stats()));
        });
  }

  /// UI Bibliotec piso 2
  @override
  Widget build(BuildContext context){
    return LoadingScreen(new Image.asset(
      'images/biblioOutside.jpg',
      fit: BoxFit.cover,
      height: 800,
      color: Colors.blue[900],
      colorBlendMode: BlendMode.multiply,),
    );
  }

  /// WIDGETS de UI bibliotec piso2
  // Despliega el estatus de disponibilidad de Bibliotec Piso 2
  Widget stats() {
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
                  recommendations()
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
          "Lleno",
          style: TextStyle(
            fontFamily: 'Bebas',
            fontSize: 60,
            color: Colors.red,
          ),
        )
    );
  }

  /// Crea la gráfica
  Widget chart() {
    return charts.LineChart(
      series,
      defaultRenderer: new charts.LineRendererConfig(
          includePoints: true, stacked: true),
      animate: true,
      behaviors: [
        new charts.ChartTitle("Horas",
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification: charts.OutsideJustification
                .middleDrawArea),
        new charts.ChartTitle('Ocupación',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification
                .middleDrawArea),
      ],
      primaryMeasureAxis:
      new charts.NumericAxisSpec(
          showAxisLine: true,
          renderSpec: new charts.NoneRenderSpec()),
    );
  }

  // Despliega la gráfica
  // Parte de UI
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
              child: chart(),
            ),
          ),
        )
    );
  }

  Widget recommendations() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Container(
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
          padding: new EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Mejor horario de visita: ',
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 25,
                          color: Colors.blue[900]
                      ),
                    ),
                    Text(
                      '6PM - 11PM ',
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 25,
                          color: Colors.green[700]
                      ),
                    )
                  ]
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Peor horario de visita: ',
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 25,
                          color: Colors.blue[900]
                      ),
                    ),
                    Text(
                      '1PM - 4PM ',
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 25,
                          color: Colors.red[700]
                      ),
                    )
                  ]
              ),
            ],
          ),
        ),
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