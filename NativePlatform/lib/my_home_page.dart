import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('com.example.flutter.dev/device_info');

  String model = 'Undefined';
  String systemVersion = 'Undefined';

  Future _getDeviceInfo() async {
    try {
      final arg = await platform.invokeMethod('getDeviceInfo');
      setState(() {
        model = arg['model'] as String;
        systemVersion = arg['systemVersion'] as String;
      });
    } on PlatformException catch (e) {
      model = "Failed to get model:' ${e.message} '.";
      systemVersion = "Failed to get version:' ${e.message} '.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Channel'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Get Device Info'),
                onPressed: _getDeviceInfo,
              ),
              Text('Model: $model'),
              Text('Version: $systemVersion'),
            ],
          ),
        ),
      ),
    );
  }
}
