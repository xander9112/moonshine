import 'package:calc/core/assets.dart';
import 'package:flutter/material.dart';

import '../core/translation_service.dart';
import 'screens/index.dart';
import 'widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TranslationService _translationService = TranslationService();

  final widgetOptions = [
    CorrectionByTemperature(),
    AbsoluteAlcoholContent(),
    DilutionAlcohol(),
    VolumeSugar(),
  ];

  final widgetOptionsTitle = [
    CorrectionByTemperature.title,
    AbsoluteAlcoholContent.title,
    DilutionAlcohol.title,
    VolumeSugar.title,
  ];

  int selectedIndex = 0;

  void _openSettings() {
    print('_openSettings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_translationService
            .text(widgetOptionsTitle.elementAt(selectedIndex))),
        actions: <Widget>[
          IconButton(
            onPressed: _openSettings,
            icon: Icon(Icons.settings),
          )
        ],
      ),
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
