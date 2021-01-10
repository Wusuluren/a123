import 'package:a123/conf.dart';

SmsNotify Sms;

void InitSmsNotify() {
  Sms = new SmsNotify();
}

class SmsNotify {
  sendSms(String msg) {
    // SmsSender sender = new SmsSender();
    // sender.sendSms(new SmsMessage(conf.contract.mobile, msg));
  }
}
