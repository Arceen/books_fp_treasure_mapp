import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'picture_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  List<CameraDescription> cameras = [];
  late CameraDescription camera;
  Widget? cameraPreview;
  Image? image;
  BuildContext? buildContext;
  Future setCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera = cameras.first;
    }
  }

  @override
  void initState() {
    setCamera().then((_) {
      _controller = CameraController(camera, ResolutionPreset.ultraHigh);

      _controller.initialize().then((snapshot) {
        cameraPreview = Stack(children: [
          Container(
              alignment: Alignment.center, child: CameraPreview(_controller)),
          Container(
            alignment: Alignment.bottomCenter,
            child: Builder(builder: (context) {
              return TextButton(
                onPressed: () async {
                  final path = join((await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png');
                  XFile file = await _controller.takePicture();
                  print(file.path);
                  print(file.name);
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PictureScreen(file.path)));
                  });
                },
                child: Icon(Icons.camera_alt),
              );
            }),
          ),
        ]);
        setState(() {
          cameraPreview = cameraPreview;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: cameraPreview ?? Container());
  }
}
