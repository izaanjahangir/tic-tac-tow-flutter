import 'package:flutter/material.dart';
import 'package:tic_tac_toe/config/theme_colors.dart';

class Cross extends StatefulWidget {
  final double stroke;
  Cross({this.stroke = 3});

  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

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
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomPaint(
            painter: CirclePainter(fraction: _fraction, stroke: widget.stroke),
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
  final double stroke;
  var _crossPaint;

  CirclePainter({this.fraction, this.stroke}) {
    _crossPaint = Paint()
      ..color = ThemeColors.themeSecondaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double fraction2 = 1 - fraction;
    canvas.drawLine(new Offset(0, 0),
        new Offset(size.width * fraction, size.height * fraction), _crossPaint);
    canvas.drawLine(
        new Offset(size.width, 0),
        new Offset(size.width * fraction2, size.height * fraction),
        _crossPaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
