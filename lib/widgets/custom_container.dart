import 'package:flutter/material.dart';

class CustomContainer extends CustomPainter {
  final Color bgColor;

  CustomContainer(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint();
    paint.color = bgColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width/2, size.height * 0.4, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

    return false;
  }
}