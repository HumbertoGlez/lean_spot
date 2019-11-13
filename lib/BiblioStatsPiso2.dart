import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

    /// SET UP THE GRAPH
    var data = [
      new DevicesPerHour(1, 50, Colors.red),
      new DevicesPerHour(2, 75, Colors.blue),
      new DevicesPerHour(3, 65, Colors.green),
      new DevicesPerHour(4, 60, Colors.purple),
      new DevicesPerHour(5, 50, Colors.orange),
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
      defaultRenderer: new charts.LineRendererConfig(includePoints: true, stacked: true),
      animate: true,
      behaviors: [
        new charts.ChartTitle('Hora',
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Ocupación',
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
      ],
      primaryMeasureAxis:
          new charts.NumericAxisSpec(
              showAxisLine: true,
              renderSpec: new charts.NoneRenderSpec()),
    );

    /// WIDGETS FOR THIS SCREEN
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
    
    Widget recommendations() {
      return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Container(
          height: 90,
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
}

class DevicesPerHour{
  final int hour;
  final int devices;
  final charts.Color color;

  DevicesPerHour(this.hour, this.devices, Color color)
    : this.color = new charts.Color(
    r: color.red, g: color.green, b: color.blue, a: color.alpha);
}