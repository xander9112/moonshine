import 'package:calc/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/index.dart';
import 'widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final widgetOptions = [
    AbsoluteAlcoholContent(),
    CorrectionByTemperature(),
    DilutionAlcohol(),
    VolumeShugar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        items: [
          Assets.correctionByTemperature,
          Assets.absoluteAlcoholContent,
          Assets.dilutionAlcohol,
          Assets.volumeShugar,
        ],
        index: selectedIndex,
        fixedColor: Theme.of(context).primaryColor,
        onPressed: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
