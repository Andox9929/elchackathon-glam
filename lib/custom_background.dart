import 'package:ecommerce_int2/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class MainBackground extends CustomPainter {
  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    // create a gradient background
    var gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromARGB(255, 19, 224, 224),Color.fromRGBO(247,247,247,1.000)],
    );

    // draw the gradient background
    var backgroundPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTRB(0, 0, width, height));
    canvas.drawRect(Rect.fromLTRB(0, 0, width, height), backgroundPaint);

    // create a custom shape
    var shape = Path();
    shape.moveTo(0, height * 0.5);
    shape.lineTo(width * 0.3, height * 0.3);
    shape.quadraticBezierTo(width * 0.4, height * 0.25, width * 0.5, height * 0.3);
    shape.quadraticBezierTo(width * 0.625, height * 0.375, width * 0.75, height * 0.25);
    shape.quadraticBezierTo(width * 0.875, height * 0.125, width, height * 0.5);
    shape.lineTo(width, height * 0.8);
    shape.quadraticBezierTo(width * 0.9, height * 0.9, width * 0.7, height * 0.9);
    shape.quadraticBezierTo(width * 0.5, height * 0.9, width * 0.5, height * 0.8);
    shape.quadraticBezierTo(width * 0.5, height * 0.7, width * 0.3, height * 0.7);
    shape.quadraticBezierTo(width * 0.1, height * 0.7, 0, height * 0.8);
    shape.close();

    // draw the custom shape
    var shapePaint = Paint()..color = Color.fromRGBO(247,247,247,1.000);
    canvas.drawPath(shape, shapePaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
