import 'package:flutter/material.dart';
import 'package:fudeo_start_stream_app/news_stream.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: StreamBuilder(
          stream: NewsStream().getStream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Text(
                  snapshot.data.toString(),
                );

              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
