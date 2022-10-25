import 'dart:io';
import 'package:flutter/material.dart';
import 'package:treasure_mapp/camera_screen.dart';
import './main.dart';

class PictureScreen extends StatelessWidget {
  final String imagePath;
  PictureScreen(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Save picture'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => CameraScreen());
                Navigator.push(context, route);
              },
            )
          ],
        ),
        body: Container(
          child: Image.file(File(imagePath)),
        ));
  }
}
