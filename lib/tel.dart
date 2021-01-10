import 'package:a123/conf.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

TelNotify Tel;

void InitTelNotify() {
  Tel = new TelNotify();
}

class TelNotify {
  Future<bool> makeCall() async {
    var number = conf.contract.mobile; //set the number here
    bool res;
    await FlutterPhoneDirectCaller.directCall(number).then((value) {
      res = value;
    });
    return res;
  }
}
