import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController? controller;
  List<CameraDescription> availCameras = [];
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  void initCamera() async {
    availCameras = await availableCameras();
    if (availCameras.isNotEmpty) {
      controller = CameraController(availCameras[0], ResolutionPreset.max);
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          isCameraInitialized = true;
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isCameraInitialized)
        ? CameraPreview(controller!)
        : const Center(
            child: Text('Uruchamiam kamerę'),
          );
  }

  // Widget tree() {

  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
