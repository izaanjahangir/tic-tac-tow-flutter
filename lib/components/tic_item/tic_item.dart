import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';

class TicItem extends StatelessWidget {
  final String type;
  final Function onTap;

  TicItem({this.type, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget renderSymbol() {
      if (type == "circle") {
        return Circle();
      }

      if (type == "cross") {
        return Cross();
      }

      return null;
    }

    return Container(
      width: 50,
      height: 50,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: GestureDetector(
        onTap: onTap,
        child: renderSymbol(),
      ),
    );
  }
}
