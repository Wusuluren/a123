// import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';

// List<CameraDescription> cameras;
CameraNotify Camera;

Future<void> InitCameraNotify() async {
  Camera = new CameraNotify();

  WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
}

class CameraNotify {
  sendCamera(String msg) {
    // CameraController controller =
    //     CameraController(cameras[0], ResolutionPreset.high);
    // controller.initialize();

    // CameraSender sender = new CameraSender();
    // sender.sendCamera(new CameraMessage(conf.contract.mobile, msg));
  }
}
