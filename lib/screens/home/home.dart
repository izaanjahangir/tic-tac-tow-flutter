import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tic_tac_toe/components/app_header/app_header.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';
import 'package:tic_tac_toe/components/tic_item/tic_item.dart';
import 'package:tic_tac_toe/config/theme_colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool isShowing = false;
  bool isGameEnded = false;
  String wonPlayer = null;
  String currentPlayer = "circle";
  List<List<String>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  List<List<List<int>>> winningConditions = [
    [
      [0, 0],
      [0, 1],
      [0, 2],
    ],
    [
      [1, 0],
      [1, 1],
      [1, 2],
    ],
    [
      [2, 0],
      [2, 1],
      [2, 2],
    ],
    [
      [0, 0],
      [1, 0],
      [2, 0],
    ],
    [
      [0, 1],
      [1, 1],
      [2, 1],
    ],
    [
      [0, 2],
      [1, 2],
      [2, 2],
    ],
    [
      [0, 0],
      [1, 1],
      [2, 2],
    ],
    [
      [0, 2],
      [1, 1],
      [2, 0],
    ]
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void startGame() {
      setState(() {
        isGameEnded = false;
        wonPlayer = null;
        currentPlayer = "circle";
        board = [
          [null, null, null],
          [null, null, null],
          [null, null, null],
        ];
      });
    }

    void changePlayer() {
      String newPlayer;

      if (currentPlayer == "circle") {
        newPlayer = "cross";
      }

      if (currentPlayer == "cross") {
        newPlayer = "circle";
      }

      setState(() {
        currentPlayer = newPlayer;
      });
    }

    void win() {
      setState(() {
        wonPlayer = currentPlayer;
        isGameEnded = true;
      });
    }

    void draw() {
      setState(() {
        wonPlayer = "draw";
        isGameEnded = true;
      });
    }

    bool checkDrawState() {
      bool isDrawn = true;

      for (int i = 0; i < board.length; i++) {
        List items = board[i];

        for (int j = 0; j < items.length; j++) {
          if (items[j] == null) {
            isDrawn = false;
            break;
          }
        }

        if (!isDrawn) {
          break;
        }
      }

      return isDrawn;
    }

    void checkWinningState() {
      final isDraw = checkDrawState();

      if (isDraw) {
        draw();
        return;
      }

      for (int i = 0; i < winningConditions.length; i++) {
        List element = winningConditions[i];

        int correctCount = 0;

        for (int j = 0; j < element.length; j++) {
          List<int> condition = element[j];
          int col = condition[0];
          int row = condition[1];

          if (board[col][row] == currentPlayer) {
            correctCount++;
          } else {
            break;
          }
        }

        if (correctCount == 3) {
          win();
          break;
        }
      }

      changePlayer();
    }

    void handleSelection(row, column) {
      if (board[row][column] == null) {
        setState(() {
          board[row][column] = currentPlayer;
          checkWinningState();
        });
      }
    }

    BoxDecoration calculateBoxDecoration(
        int row, int column, int maxRow, int maxColumn) {
      BoxDecoration boxDecoration;
      BorderSide borderSide = BorderSide(color: Colors.grey, width: 2);

      if (row == 0) {
        if (column == 0) {
          boxDecoration = BoxDecoration(
              border: Border(right: borderSide, bottom: borderSide));
        } else if (column == maxColumn) {
          boxDecoration = BoxDecoration(border: Border(bottom: borderSide));
        } else {
          boxDecoration = BoxDecoration(
              border: Border(bottom: borderSide, right: borderSide));
        }
      } else if (row == maxRow) {
        if (column == 0) {
          boxDecoration = BoxDecoration(
              border: Border(
            right: borderSide,
          ));
        } else if (column == maxColumn) {
          boxDecoration = BoxDecoration(border: Border());
        } else {
          boxDecoration = BoxDecoration(
            border: Border(right: borderSide),
          );
        }
      } else {
        if (column == 0) {
          boxDecoration = BoxDecoration(
              border: Border(right: borderSide, bottom: borderSide));
        } else if (column == maxColumn) {
          boxDecoration = BoxDecoration(border: Border(bottom: borderSide));
        } else {
          boxDecoration = BoxDecoration(
              border: Border(bottom: borderSide, right: borderSide));
        }
      }

      return boxDecoration;
    }

    List<Widget> renderBoard(BoxConstraints constraints) {
      List<Widget> finalItems = [];

      final double size = constraints.maxWidth / board[0].length;

      for (int i = 0; i < board.length; i++) {
        List<String> row = board[i];
        List<Widget> items = [];

        for (int j = 0; j < row.length; j++) {
          BoxDecoration boxDecoration =
              calculateBoxDecoration(i, j, board.length - 1, row.length - 1);

          items.add(TicItem(
            size: size,
            boxDecoration: boxDecoration,
            onTap: () => handleSelection(i, j),
            type: row[j],
          ));
        }

        finalItems.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ));
      }

      return finalItems;
    }

    Widget renderWhoWon() {
      if (wonPlayer == "draw") {
        return Text(
          'Draw',
          style: TextStyle(
              color: ThemeColors.themeSecondaryLight,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            child: wonPlayer == "circle"
                ? Circle(
                    stroke: 2,
                  )
                : Cross(
                    stroke: 2,
                  ),
          ),
          Text(
            "won",
            style: TextStyle(
                color: ThemeColors.themeSecondaryLight,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            color: ThemeColors.themePrimaryDark,
            child: Stack(
              children: [
                Column(
                  children: [
                    AppHeader(currentPlayer: currentPlayer),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tic Tac Toe",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ThemeColors.themeSecondaryLight,
                                  fontSize: width * 0.1 > 60 ? 60 : width * 0.1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                return AbsorbPointer(
                                  absorbing: isGameEnded,
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: renderBoard(constraints),
                                      ),
                                      BackdropFilter(
                                        filter: isGameEnded
                                            ? ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10)
                                            : ImageFilter.blur(
                                                sigmaX: 0, sigmaY: 0),
                                        child: Container(
                                          width: double.infinity,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (isGameEnded)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        renderWhoWon(),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ThemeColors.themePrimaryDark),
                            onPressed: () {
                              startGame();
                            },
                            child: Text("Start Again"))
                      ],
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
