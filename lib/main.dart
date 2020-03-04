import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() => runApp(MoonshineApp());

class MoonshineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moonshine Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
