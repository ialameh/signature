import 'package:flutter/material.dart';
import 'package:signature/signature_pad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

List<Offset> _offsets = [];
Size size;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SignaturePadContainer(),
        ),
      ),
    ));
  }
}

class SignaturePadContainer extends StatefulWidget {
  @override
  _SignaturePadContainerState createState() => _SignaturePadContainerState();
}

class _SignaturePadContainerState extends State<SignaturePadContainer> {
    GlobalKey _keyContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyContainer,
      width: double.infinity,
      height: 400,
      color: Colors.grey,
      child: GestureDetector(
        onPanUpdate: (details) {
          RenderBox object =
              _keyContainer.currentContext.findRenderObject();
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
      ),
    );
  }
}
