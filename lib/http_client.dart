import 'dart:convert';
import 'package:dio/dio.dart';

class HttpResp {
  dynamic resp;

  Map<String, dynamic> json() {
    // var data = new Map<String, dynamic>();
    // print(resp);
    // data = jsonDecode(resp);
    // print(data);
    // return data;
    print(resp);
    return resp;
  }

  String text() {
    return resp;
  }
}

class HttpClient {
  Future<HttpResp> post(String url, Map<String, dynamic> param) async {
    var resp = new HttpResp();
    try {
      var value = await Dio().post(url, data: param);
      print(value);
      resp.resp = value.data;
    } catch (e) {
      print(e);
    }
    return resp;
  }

  Future<HttpResp> get(String url, {Map<String, dynamic> headers}) async {
    var resp = new HttpResp();
    try {
      var dio = Dio();
      var value = await dio.get(url);
      print(value);
      resp.resp = value.data;
    } catch (e) {
      print(e);
    }
    return resp;
  }

  Future<HttpResp> get2(String url, {Map<String, dynamic> headers}) async {
    var resp = new HttpResp();
    try {
      var dio = Dio();
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      var value = await dio.get(url);
      print(value);
      resp.resp = value.data;
    } catch (e) {
      print(e);
    }
    return resp;
  }
}
