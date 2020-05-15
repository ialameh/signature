import 'package:flutter/material.dart';
import 'package:signature/signature_pad.dart';
import  'dart:ui' as ui;

class SignaturePadContainer extends StatefulWidget {
  final GlobalKey _keyContainer;
  
  SignaturePadContainer(this._keyContainer,  {Key key}) : super(key: key);
  
  // @override
  // SignaturePadContainerState createState() => SignaturePadContainerState();

  
    @override
  State<StatefulWidget> createState() {
    return SignaturePadContainerState();
  }
}

class SignaturePadContainerState extends State<SignaturePadContainer> {
  final List<Offset> _offsets = [];
  var image;

  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePad painter  = SignaturePad(_offsets);
    var size =  widget._keyContainer.currentContext.size;
    painter.paint(canvas, size);
    return recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox object =
            widget._keyContainer.currentContext.findRenderObject();
        setState(() {
          _offsets.add(object.globalToLocal(details.globalPosition));
        });

      },
      onPanEnd: (details) {
        setState(() {
          _offsets.add(null);
        });
      },
      child: ClipRect(
        child: CustomPaint(
          painter: SignaturePad(_offsets),
        ),
      ),
    );
  }
} 
