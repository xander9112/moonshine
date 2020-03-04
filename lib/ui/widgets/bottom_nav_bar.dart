import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  final List<String> items;
  final int index;
  final Color fixedColor;
  final Function(int index) onPressed;

  BottomNavBar(
      {@required this.items, this.index, this.fixedColor, this.onPressed});

  bool isActive(item) {
    return items.indexOf(item) == index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.02),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items
              .map<Widget>((item) => MaterialButton(
                    height: 80,
                    onPressed: onPressed != null
                        ? () => onPressed(items.indexOf(item))
                        : null,
                    child: SvgPicture.asset(
                      item,
                      color: isActive(item)
                          ? fixedColor
                          : Colors.black.withOpacity(0.54),
                    ),
                  ))
              .toList()),
    );
  }
}
