import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';

class TicItem extends StatelessWidget {
  final String type;
  final Function onTap;
  final double size;
  final BoxDecoration boxDecoration;

  TicItem(
      {this.type, @required this.onTap, this.size = 50, this.boxDecoration});

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

    BoxDecoration getContainerDecoration() {
      BoxDecoration defaultBoxDecoration =
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1));
      BoxDecoration clonedDecoration =
          boxDecoration == null ? BoxDecoration() : boxDecoration;

      BoxDecoration finalDecoration = defaultBoxDecoration.copyWith(
          border: clonedDecoration.border == null
              ? defaultBoxDecoration.border
              : clonedDecoration.border);

      return finalDecoration;
    }

    return Container(
      width: size > 200 ? 200 : size,
      height: size > 200 ? 200 : size,
      decoration: getContainerDecoration(),
      child: GestureDetector(
        onTap: onTap,
        child: renderSymbol(),
      ),
    );
  }
}
