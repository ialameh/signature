import 'dart:io';
import 'dart:async';
    import 'dart:html' as Html;

import 'dart:typed_data';
import  'package:image/image.dart'as image;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:signature/signature_pad_container.dart';
import 'dart:ui' as ui;

const directoryName = 'Signature';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey _keyContainer = GlobalKey();

  final GlobalKey<SignaturePadContainerState> signatureKey = GlobalKey();
  var image;


  setRenderedImage(BuildContext context) async {
    
    ui.Image renderedImage = await signatureKey.currentState.rendered;

    setState(() {
      image = renderedImage;
    });
    showImage(context);
  }
  image.Image getImageFromCanvas(Html.CanvasElement canvas) {
      var imageData = canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);
      return image.Image.fromBytes(canvas.width, canvas.height, imageData.data);
    }

Future<Null> showImage(BuildContext context) async {

    // Use plugin [path_provider] to export image to storage
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    print(path);
    //await Directory('$path/$directoryName').create(recursive: true);
    var  fileName= '$path/${formattedDate()}.png';
    File(fileName)
        .writeAsBytesSync(image.encodingPng(getImageFromCanvas(image)));
    print('file  saved $fileName');
  }

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String dateTimeString = 'Signature_' +
        dateTime.year.toString() +
            dateTime.month.toString() +
            dateTime.day.toString() +
            dateTime.hour.toString() +
            ':' + dateTime.minute.toString() +
            ':' + dateTime.second.toString() +
            ':' + dateTime.millisecond.toString() +
            ':' + dateTime.microsecond.toString();
    return dateTimeString;
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                  key: _keyContainer,
                  width: double.infinity,
                  height: 400,
                  color: Colors.grey,
                  child: SignaturePadContainer(_keyContainer, key: signatureKey)),
              FlatButton(
                onPressed: () {
                  setRenderedImage(context);
                },
                child: Text('Press   Me'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
