import 'package:flutter/material.dart';

class InputColumn extends StatelessWidget {
  final Widget child;

  InputColumn({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[child],
    ));
  }
}
