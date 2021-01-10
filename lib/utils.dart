import 'package:a123/http_client.dart';

Utils utils;

void InitUtils() {
  utils = new Utils();
  utils.client = new HttpClient();
}

class Utils {
  HttpClient client;

  Future<String> getIp() async {
    String ip = "";
    var headers = {
      "User-Agent": "curl/7.54.0",
      "Host": "ip.sb",
      "Accept": "*/*",
    };
    var value = await client.get2("http://ip.sb", headers: headers);
    print(value.text());
    ip = value.text();
    return ip;
  }
}
