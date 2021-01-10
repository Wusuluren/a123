Conf conf;

// TODO fill the configure
void InitConf() {
  conf = new Conf();
  conf.wechat = new ConfWeChat();
  conf.gaode = new ConfGaoDe();
  conf.contract = new ConfContract();
}

class ConfWeChat {
  String corpid;
  String corpsecret;
  String agentid;
}

class ConfGaoDe {
  String key;
}

class ConfContract {
  String mobile;
}

class Conf {
  ConfWeChat wechat;
  ConfGaoDe gaode;
  ConfContract contract;
}
