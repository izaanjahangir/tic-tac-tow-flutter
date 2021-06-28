import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/circle/circle.dart';
import 'package:tic_tac_toe/components/cross/cross.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Container(
              child: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.black26),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowing = !isShowing;
                        });
                      },
                      child: isShowing ? Cross() : null))
            ],
          )),
        ),
      ),
    );
  }
}
