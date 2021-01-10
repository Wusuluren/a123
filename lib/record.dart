import 'dart:async';
// import 'package:flutter_sound/flutter_sound.dart';

RecordNotify Record;

void InitRecordNotify() {
  Record = new RecordNotify();

  // Record.flutterSound = new FlutterSound();
  // Record.flutterSound.setSubscriptionDuration(0.01);
  // Record.flutterSound.setDbPeakLevelUpdate(0.8);
  // Record.flutterSound.setDbLevelEnabled(true);
}

class RecordNotify {
  // StreamSubscription _recorderSubscription;
  // StreamSubscription _dbPeakSubscription;
  // FlutterSound flutterSound;
  //
  // String path;
  //
  // double slider_current_position = 0.0;
  // double max_duration = 1.0;
  //
  // void startRecorder() async {
  //   try {
  //     path = await flutterSound
  //       ..startRecorder(null, bitRate: 320000);
  //     print("数据$path");
  //
  //     _recorderSubscription =
  //         flutterSound.onRecorderStateChanged.listen((e) {});
  //   } catch (err) {
  //     print('startRecorder error: $err');
  //   }
  // }
  //
  // void stopRecorder() async {
  //   try {
  //     String result = await flutterSound.stopRecorder();
  //     print('停止录音返回结果: $result');
  //
  //     if (_recorderSubscription != null) {
  //       _recorderSubscription.cancel();
  //       _recorderSubscription = null;
  //     }
  //     if (_dbPeakSubscription != null) {
  //       _dbPeakSubscription.cancel();
  //       _dbPeakSubscription = null;
  //     }
  //   } catch (err) {
  //     print('stopRecorder error: $err');
  //   }
  // }
}
