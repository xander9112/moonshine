import 'package:flutter/material.dart';

class InputWrap extends StatelessWidget {
  final String labelText;
  final bool required;
  final bool showBorder;
  final Widget child;
  final double marginBottom;

  InputWrap({
    this.child,
    this.required = false,
    this.showBorder = true,
    this.labelText,
    this.marginBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom:
                BorderSide(color: Colors.black.withOpacity(0.54), width: 1.0),
          ),
        ),
        child: SizedOverflowBox(
          alignment: Alignment.topCenter,
          size: Size(0, 50),
          child: child,
        ),
      ),
    );
  }
}
