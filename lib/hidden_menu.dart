import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu_right.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';

class HiddenMenu extends StatefulWidget {
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage background;

  /// that allows us to add shadow above menu items
  final bool enableShadowItensMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color backgroundColorMenu;

  /// Items of the menu
  final List<ItemHiddenMenu> itens;

  /// Callback to recive item selected for user
  final Function(int) selectedListern;

  /// position to set initial item selected in menu
  final int initPositionSelected;

  final TypeOpen typeOpen;

  HiddenMenu(
      {Key key,
        this.background,
        this.itens,
        this.selectedListern,
        this.initPositionSelected,
        this.backgroundColorMenu,
        this.enableShadowItensMenu = false,
        this.typeOpen = TypeOpen.FROM_LEFT})
      : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  int _indexSelected;
  bool isconfiguredListern = false;

  @override
  void initState() {
    _indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isconfiguredListern) {
      confListern();
      isconfiguredListern = true;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.background,
          color: widget.backgroundColorMenu,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                alignment: Alignment(-.8, 1),
                child: Text(
                  'Lean Spot',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontFamily: 'Silent Reaction',
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                alignment: Alignment(0, 1),
                padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                decoration: BoxDecoration(
                    boxShadow: widget.enableShadowItensMenu
                        ? [
                      new BoxShadow(
                        color: const Color(0x44000000),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 50.0,
                        spreadRadius: 30.0,
                      ),
                    ]
                        : []),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (scroll) {
                    scroll.disallowGlow();
                    return false;
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      itemCount: widget.itens.length,
                      itemBuilder: (context, index) {
                        if (widget.typeOpen == TypeOpen.FROM_LEFT) {
                          return ItemHiddenMenu(
                            name: widget.itens[index].name,
                            selected: index == _indexSelected,
                            colorLineSelected:
                            widget.itens[index].colorLineSelected,
                            baseStyle: widget.itens[index].baseStyle,
                            selectedStyle: widget.itens[index].selectedStyle,
                            onTap: () {
                              if(widget.itens[index].onTap != null){
                                widget.itens[index].onTap();
                              }
                              SimpleHiddenDrawerProvider.of(context)
                                  .setSelectedMenuPosition(index);
                            },
                          );
                        } else {
                          return ItemHiddenMenuRight(
                            name: widget.itens[index].name,
                            selected: index == _indexSelected,
                            colorLineSelected:
                            widget.itens[index].colorLineSelected,
                            baseStyle: widget.itens[index].baseStyle,
                            selectedStyle: widget.itens[index].selectedStyle,
                            onTap: () {
                              SimpleHiddenDrawerProvider.of(context)
                                  .setSelectedMenuPosition(index);
                            },
                          );
                        }
                      }),
                ),
              ),
            ),
          ],
        )

      ),
    );
  }

  void confListern() {
    SimpleHiddenDrawerProvider.of(context)
        .getPositionSelectedListener()
        .listen((position) {
      setState(() {
        _indexSelected = position;
      });
    });
  }
}