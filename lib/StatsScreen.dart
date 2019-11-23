import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lean_spot/homePage.dart';
import 'package:mysql1/mysql1.dart' as mysql;
import 'dart:async';
import 'dart:io';
import 'loadingScreen.dart';
import 'BiblioTec.dart';

class StatsScreen extends StatefulWidget {
  final String lugar;
  final Image backgroundImage;
  final String queryHoras;
  final String queryRealTime;
  StatsScreen({
    Key key,
    this.lugar,
    this.backgroundImage,
    this.queryHoras,
    this.queryRealTime,

  }) : super(key: key);

  @override
  StatsScreenState createState() => new StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> with TickerProviderStateMixin{
  List<int> _horas = List<int>();
  List<int> _valores = List<int>();
  List<int> _minutos = List<int>();
  List<int> _valoresMin = List<int>();
  List<int> _horaRealtime = List<int>();
  var dataHoras, seriesHoras, dataRealTime, seriesRealTime;
  Timer everyMinute;

  /// Function to get the data of the desired spot with the provided queries
  Future getDataHours() async{
    // Open a connection (testdb should already exist)
    final connection = await mysql.MySqlConnection.connect(new mysql.ConnectionSettings(
        host: '35.188.61.105',
        port: 3306,
        user: 'root',
        password: 'PJKDp7lFjA1jxyn0',
        db: 'EMPLEATEC',
        ));
    var results = await connection.query(widget.queryHoras);

    for (var row in results) {
      _valores.add(row[1]);
      _horas.add(row[0]);
    }

    // Finally, close the connection
    await connection.close();
    return [_horas, _valores];
  }

  Future getDataRealTime() async{
    // Open a connection (testdb should already exist)
    final connection = await mysql.MySqlConnection.connect(new mysql.ConnectionSettings(
      host: '35.188.61.105',
      port: 3306,
      user: 'root',
      password: 'PJKDp7lFjA1jxyn0',
      db: 'EMPLEATEC',
    ));
    var realTimeResults = await connection.query(widget.queryRealTime);

    for (var row in realTimeResults) {
      _horaRealtime.add(row[0]);
      _valoresMin.add(row[2]);
      _minutos.add(row[1]);
    }

    // Finally, close the connection
    await connection.close();
    return [_horaRealtime, _minutos, _valoresMin];
  }

  void setDataHoras() {
    dataHoras = [
      new DevicesPerHour(_horas[0], _valores[0], Colors.red),
      new DevicesPerHour(_horas[1], _valores[1], Colors.blue),
      new DevicesPerHour(_horas[2], _valores[2], Colors.green),
      new DevicesPerHour(_horas[3], _valores[3], Colors.purple),
      new DevicesPerHour(_horas[4], _valores[4], Colors.orange),
      new DevicesPerHour(_horas[5], _valores[5], Colors.pink),
    ];
    seriesHoras = [
      new charts.Series<DevicesPerHour, int>(
        id: 'Hora',
        domainFn: ((DevicesPerHour fluxData, _) => fluxData.hour),
        measureFn: (DevicesPerHour fluxData, _) => fluxData.devices,
        colorFn: (DevicesPerHour fluxData, _) => fluxData.color,
        areaColorFn: (DevicesPerHour fluxData, _) => fluxData.color.lighter,
        data: dataHoras,
      ),
    ];
  }

  void setDataRealTime() {
    dataRealTime = [
      new DevicesPerHour(_minutos[0], _valoresMin[0], Colors.red),
      new DevicesPerHour(_minutos[1], _valoresMin[1], Colors.blue),
      new DevicesPerHour(_minutos[2], _valoresMin[2], Colors.green),
      new DevicesPerHour(_minutos[3], _valoresMin[3], Colors.purple),
      new DevicesPerHour(_minutos[4], _valoresMin[4], Colors.orange),
    ];
    seriesRealTime = [
      new charts.Series<DevicesPerHour, int>(
        id: 'Hora',
        domainFn: ((DevicesPerHour fluxData, _) => fluxData.hour),
        measureFn: (DevicesPerHour fluxData, _) => fluxData.devices,
        colorFn: (DevicesPerHour fluxData, _) => fluxData.color,
        areaColorFn: (DevicesPerHour fluxData, _) => fluxData.color.lighter,
        data: dataRealTime,
      ),
    ];
  }

  @override
  void initState(){
    super.initState();
    /// Get data from the database
    Future
        .wait([getDataHours(), getDataRealTime()])
        .then((List responses) {
          setState(() {
            this._horas = responses[0][0];
            this._valores = responses[0][1];
            this._minutos = responses[1][1];
            this._valoresMin = responses[1][2];
          });
          // Check if we didnt get any data
          if (_horas.isEmpty || _valores.isEmpty || _minutos.isEmpty || _valoresMin.isEmpty) {
            showError('No hay datos disponibles de este lugar.');
          }
          else {
            setDataHoras();
            setDataRealTime();

            /// Go from the loading screen to stats page when the data has been received
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => stats()));

            everyMinute = Timer(Duration(seconds: 60), () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new StatsScreen(
                lugar: widget.lugar,
                backgroundImage: widget.backgroundImage,
                queryHoras: widget.queryHoras,
                queryRealTime: widget.queryRealTime,
              )));
            });
          }
        })
        .catchError((e) => showError('No se pudo conectar a la base de datos.'));
  }
  @override
  Widget build(BuildContext context){
    /// Show loading screen by default
    /// SE MANDA A LOADING SCREEN APENAS SE ENTRA
    return LoadingScreen(
            widget.backgroundImage
          );
  }

  ///---- WIDGETS FOR THIS SCREEN ----

  ///
  // Main stats page widget
  Widget stats() {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          Center(
            child: widget.backgroundImage,
          ),
          ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        widget.lugar + ':',
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
                  realTimeGraph()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  hourGraph()
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

  // main status element of the stats page, called inside stats() widget
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

  // Graph element of the stats page, called inside stats() widget
  Widget hourGraph() {
    return Padding(
        padding: EdgeInsets.only(top: 30),
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
              child: chartHoras(),
            ),
          ),
        )
    );
  }

  // set up the chart for the hourGraph() widget
  Widget chartHoras() {
    return charts.LineChart(
      seriesHoras,
      defaultRenderer: new charts.LineRendererConfig(
          includePoints: true, stacked: true, includeArea: false),
      animate: true,
      behaviors: [
        new charts.ChartTitle("Hora",
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
            renderSpec: new charts.NoneRenderSpec()
        ),
      domainAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
          new charts.BasicNumericTickProviderSpec(zeroBound: false)
      ),
    );
  }

  // Graph element of the stats page, called inside stats() widget
  Widget realTimeGraph() {
    return Padding(
        padding: EdgeInsets.only(top: 30),
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
              child: chartRealTime(),
            ),
          ),
        )
    );
  }

  // set up the chart for the realTimeGraph() widget
  Widget chartRealTime() {
    return charts.LineChart(
      seriesRealTime,
      defaultRenderer: new charts.LineRendererConfig(
          includePoints: true, stacked: true),
      animate: true,
      behaviors: [
        new charts.ChartTitle("Tiempo",
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
      domainAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
          new charts.BasicNumericTickProviderSpec(zeroBound: false)
      ),
    );
  }

  // Recommendations element of the stats page, called inside stats() widget
  Widget recommendations() {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 30),
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

  void showError(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Lo sentimos =('),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                );
              }, child: new Text('Regresar'))
            ],
          );
        }
    );
  }
}

// Data type for the graphs of the stats page
class DevicesPerHour{
  final int hour;
  final int devices;
  final charts.Color color;

  DevicesPerHour(this.hour, this.devices, Color color)
    : this.color = new charts.Color(
    r: color.red, g: color.green, b: color.blue, a: color.alpha);
}