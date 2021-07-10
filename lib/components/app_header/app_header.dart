import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';
import 'package:tic_tac_toe/config/theme_colors.dart';

class AppHeader extends StatelessWidget {
  final String currentPlayer;

  AppHeader({this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    Widget renderSymbol() {
      if (currentPlayer == "circle")
        return Circle(
          stroke: 2,
        );
      if (currentPlayer == "cross")
        return Cross(
          stroke: 2,
        );

      return Container();
    }

    return Container(
      width: double.infinity,
      height: 55,
      color: ThemeColors.themePrimaryLight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Now playing: ",
            style:
                TextStyle(color: ThemeColors.themeSecondaryLight, fontSize: 18),
          ),
          Container(width: 45, height: 45, child: renderSymbol())
        ],
      ),
    );
  }
}
