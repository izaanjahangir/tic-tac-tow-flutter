import 'dart:math';

import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomPaint(
              painter: CirclePainter(fraction: _fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CirclePainter({this.fraction}) {
    _circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & size;

    canvas.drawArc(rect, -pi / 2, pi * 2 * fraction, false, _circlePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
