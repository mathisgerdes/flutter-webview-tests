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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.futureServer}) : super(key: key);

  final Future<Jaguar> futureServer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Test'),
      ),
      body: FutureBuilder(
        future: futureServer,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) throw snapshot.error;

          if (snapshot.connectionState == ConnectionState.done)
            return WebView(
              initialUrl: 'http://localhost:$port/static/hello.html',
              javascriptMode: JavascriptMode.unrestricted,
            );
          else
            return Center(
              child: Text('Loading... (state: ${snapshot.connectionState})'),
            );
        },
      ),
    );
  }
}
