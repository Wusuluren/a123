import 'package:a123/http_client.dart';
import 'package:a123/conf.dart';
import 'package:sprintf/sprintf.dart';

WeChatNotify WeChat;

void InitWeChatNotify() {
  WeChat = new WeChatNotify();
  WeChat.client = new HttpClient();
}

class WeChatNotify {
  HttpClient client;

  Future<String> getToken() async {
    var url = sprintf(
        "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s",
        [conf.wechat.corpid, conf.wechat.corpsecret]);
    var resp = await client.get(url);
    var token = resp.json()['access_token'];
    return token;
  }

  Future<String> notify(String msg) async {
    var token = await getToken();
    print(token);

    if (msg == "") {
      msg = "something wrong";
    }

    var param = {
      "touser": "@all",
      "msgtype": "text",
      "agentid": conf.wechat.agentid,
      "text": {"content": msg},
      "safe": 0
    };

    var url = sprintf(
        "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s",
        [token]);
    var resp = await client.post(url, param);
    var json = resp.json();
    print(json);
    return json.toString();
  }
}
