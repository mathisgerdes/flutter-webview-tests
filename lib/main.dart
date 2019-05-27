import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';

void main() => runApp(MyApp());

const port = 8420;

Future<Jaguar> loadServer() async {
  final server = Jaguar(port: port);

  server.addRoute(serveFlutterAssets(path: 'static/*', stripPrefix: false));

  server.getJson('/exampleJson', (Context ctx) async {
    return {"message": "hello"}; // Automatically encodes to JSON
  });

  server.serve(logRequests: true);
  print('Server initialization done.');
  return server;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Test',
      home: MyHomePage(futureServer: loadServer()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.futureServer}) : super(key: key);

  final Future<Jaguar> futureServer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Test'),
      ),
      body: FutureBuilder(
        future: widget.futureServer,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) throw snapshot.error;

          if (snapshot.connectionState == ConnectionState.done)
            return WebView(
              initialUrl: 'http://localhost:$port/static/hello.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (c) => controller = c,
            );
          else
            return Center(
              child: Text('Loading... (state: ${snapshot.connectionState})'),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller?.evaluateJavascript('loadData();'),
        child: Icon(Icons.add),
      ),
    );
  }
}
