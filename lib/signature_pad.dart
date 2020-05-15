import 'package:flutter/material.dart';

class SignaturePad extends CustomPainter {
  final List<Offset> _offsets;
  SignaturePad(this._offsets);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < _offsets.length - 1; i++) {
      var p1 = _offsets[i];
      var p2 = _offsets[i + 1];
      if(p1 != null &&  p2 !=null) {
      canvas.drawLine(p1, p2, paint);}
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
