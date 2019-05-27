import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Test',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Test'),
      ),
      body: const WebView(
        initialUrl: 'http://detexify.kirelabs.org/classify.html',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}