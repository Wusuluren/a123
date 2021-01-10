import 'package:a123/http_client.dart';
import 'package:a123/conf.dart';
import 'package:a123/utils.dart';
import 'package:sprintf/sprintf.dart';

GaoDeNotify GaoDe;

void InitGaoDeNotify() {
  GaoDe = new GaoDeNotify();
  GaoDe.client = new HttpClient();
}

class GaoDeNotify {
  HttpClient client;

  Future<Map<String, String>> getByIp() async {
    var ip = "";
    var value = await utils.getIp();
    ip = value;

    var url = sprintf("https://restapi.amap.com/v3/ip?ip=%s&output=json&key=%s",
        [ip, conf.gaode.key]);
    String rectangle, rectangle2;
    var resp = await client.get(url);
    var json = resp.json();
    print(resp);
    print(json);
    if (json != null) {
      rectangle = json['rectangle'];
      rectangle2 = rectangle.replaceAll(";", "|");
    }

    url = sprintf(
        "https://restapi.amap.com/v3/geocode/regeo?output=json&location=%s&key=%s&radius=3000&extensions=all",
        [rectangle2, conf.gaode.key]);
    String addr;
    resp = await client.get(url);
    json = resp.json();
    print(resp);
    print(json);
    if (json != null) {
      if (json['regeocode']['formatted_address'] is String) {
        addr = json['regeocode']['formatted_address'];
      } else if (json['regeocode']['formatted_address'] is List<dynamic>) {
        List<dynamic> addrs = json['regeocode']['formatted_address'];
        if (addrs.length > 0) {
          addr = addrs[0];
        }
      }
    }

    return {'ip': ip, 'rectangle': rectangle, 'addr': addr};
  }
}
