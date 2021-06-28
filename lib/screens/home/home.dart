import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/tic_item/tic_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isShowing = false;
  String currentPlayer = "circle";
  List<List<String>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
      setState(() {
        board[row][column] = currentPlayer;
        changePlayer();
      });
    }

    BoxDecoration calculateBoxDecoration(
        int row, int column, int maxRow, int maxColumn) {
      BoxDecoration boxDecoration;
      BorderSide borderSide = BorderSide(color: Colors.grey, width: 1);

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
                    fontSize: width * 0.07 > 60 ? 60 : width * 0.07,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: renderBoard(constraints),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
