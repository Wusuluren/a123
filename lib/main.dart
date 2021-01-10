import 'package:a123/camera.dart';
import 'package:a123/tel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:a123/wechat.dart';
import 'package:a123/gaode.dart';
import 'package:a123/conf.dart';
import 'package:a123/utils.dart';
import 'package:a123/sms.dart';
import 'package:a123/record.dart';
import 'package:sprintf/sprintf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    InitConf();
    InitUtils();
    InitWeChatNotify();
    InitGaoDeNotify();
    InitSmsNotify();
    InitTelNotify();
    InitRecordNotify();
    InitCameraNotify();

    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _errMsg = "";
  List<String> _errMsgs = [];
  bool isEnable = false;
  Timer ticker;

  _incrementCounter() {
    if (!isEnable) {
      Tel.makeCall();
      ticker = new Timer.periodic(Duration(seconds: 1), _handleTimeout);
      isEnable = true;
    }
  }

  _checkErr(e) {
    var errMsg = e.toString();
    _errMsgs.add(errMsg);
    print(e);
  }

  _handleTimeout(Timer timer) async {
    if ((_counter == 0) || ((_counter + 1) % 10 == 0)) {
      _errMsgs.clear();
      var geoInfo = new Map<String, String>();
      var msg = "";

      try {
        var value = await GaoDe.getByIp();
        print(value);
        // _errMsgs.add(value.toString());
        if (value != null) {
          geoInfo = value;
        }

        msg = sprintf("报警！IP：%s，地址：%s, 坐标：%s",
            [geoInfo["ip"], geoInfo["addr"], geoInfo["rectangle"]]);
      } catch (e) {
        _checkErr(e);
      }

      try {
        var resp = await WeChat.notify(msg);
        // _errMsgs.add(resp.toString());
        print(resp);
      } catch (e) {
        _checkErr(e);
      }

      if ((_counter == 0) || ((_counter + 1) % 60 == 0)) {
        try {
          Sms.sendSms(msg);
        } catch (e) {
          _checkErr(e);
        }
      }
    }

    setState(() {
      _counter++;
      _errMsg = _errMsgs.join("\n");
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var ballSize =
        (screenHeight > screenWidth ? screenWidth : screenHeight) * 0.75;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _errMsg,
            ),
            Container(
              height: ballSize,
              width: ballSize,
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: '开始',
                child: Text(
                  "$_counter",
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
              ), // This trailing comma makes auto-formatting nicer for build methods.,
            )
          ],
        ),
      ),
    );
  }
}
