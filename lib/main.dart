import 'package:flutter/material.dart';
import 'package:lean_spot/BiblioTec.dart';
import 'package:lean_spot/Centrales.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

//var res = -1;
//Future main() async {
//  // Open a connection (testdb should already exist)
//  final conn = await MySqlConnection.connect(new ConnectionSettings(
//      host: '35.188.61.105', port: 3306, user: 'root', password: 'PJKDp7lFjA1jxyn0', db: 'EMPLEATEC'));
//
//  // Create a table
//  var res = await conn.query(
//      'SELECT COUNT(DISTINCT(mac)) FROM EMPLEATEC.conteo');
//
//  // Finally, close the connection
//  await conn.close();
//}
import 'hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "BiblioTec",
          colorLineSelected: Colors.cyan,
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
          selectedStyle: TextStyle(color: Colors.cyan),
        ),
        BiblioTec(name: "BiblioTec", mainColor: Colors.cyan,)));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Centrales",
          colorLineSelected: Colors.orange,
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
          selectedStyle: TextStyle(color: Colors.orange),
        ),
          Centrales(name: "Centrales", mainColor: Colors.orange,)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: items,
      backgroundColorMenu: Colors.blue[900],
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    slidePercent: 80.0,
      //    verticalScalePercent: 80.0,
          contentCornerRadius: 10.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
          backgroundColorAppBar: Colors.blue[700],
          elevationAppBar: 8.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
          isTitleCentered: true,
          isDraggable: true,
      //    enableShadowItensMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}


//import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
//import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
//import 'BiblioTec.dart';
//import 'Centrales.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  static List<ScreenHiddenDrawer> items = new List();
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Menu(),
//    );
//  }
//}
//
//class Menu extends StatefulWidget {
//  Menu({Key key}) : super(key: key);
//
//  @override
//  _MenuState createState() => _MenuState();
//}
//
//class _MenuState extends State<Menu> {
////    with TickerProviderStateMixin{
////
////  AnimationController _animationController;
////  bool initConfigState = false;
////  int _indexSelected;
//
//  @override
//  void initState() {
////    _indexSelected = widget.ini
////    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
//
//    MyApp.items.add(new ScreenHiddenDrawer(
//        new ItemHiddenMenu(
//          name: "BiblioTec",
//          colorLineSelected: Colors.cyan,
//          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
//          selectedStyle: TextStyle(color: Colors.cyan),
//    ), BiblioTec(name: 'BiblioTec', mainColor: Colors.cyan,)));
//
//    MyApp.items.add(new ScreenHiddenDrawer(
//        new ItemHiddenMenu(
//      name: "Centrales",
//      colorLineSelected: Colors.orange,
//      baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
//      selectedStyle: TextStyle(color: Colors.orange),
//    ), Centrales(name: 'Centrales', mainColor: Colors.orange,)));
//
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MyApp.items[0].screen;
//  }
//}