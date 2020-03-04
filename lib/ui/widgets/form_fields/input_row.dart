import 'package:flutter/material.dart';

import 'input_column.dart';

class InputRow extends StatelessWidget {
  final List<Widget> children;

  InputRow({this.children});

  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map<Widget>((child) => Expanded(
                  child: InputColumn(
                child: child,
              )))
          .toList(),
    ));
  }

  /**
    return Container(
      width: double.infinity,
      height: 50,
      child: GridView.count(
          crossAxisCount: 2,
          children: children
              .map<Widget>((child) => InputColumn(
                    child: child,
                    height: height,
                  ))
              .toList()),
    );
   */
}
