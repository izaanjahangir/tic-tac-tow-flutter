import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';
import 'package:tic_tac_toe/components/tic_item/tic_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isShowing = false;
  String currentPlayer = "circle";
  List<List<String>> board = [
    [null, null, null]
  ];

  @override
  Widget build(BuildContext context) {
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

    void handleSelection(row, column) {
      print("row " + row.toString());
      print("column " + column.toString());

      setState(() {
        board[row][column] = currentPlayer;
        changePlayer();
      });
    }

    List<Widget> renderBoard() {
      List<Widget> finalItems = [];

      for (int i = 0; i < board.length; i++) {
        List<String> row = board[i];
        List<Widget> items = [];

        for (int j = 0; j < row.length; j++) {
          items.add(TicItem(
            onTap: () => handleSelection(i, j),
            type: row[j],
          ));
        }

        finalItems.add(Row(
          children: items,
        ));
      }

      return finalItems;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tic Tac Toe",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              ...renderBoard()
            ],
          ),
        ),
      ),
    );
  }
}
