import 'package:flutter/material.dart';
import 'package:fudeo_start_stream_app/article.dart';
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
  Widget buildArticle(BuildContext context, Article randomArticle) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(randomArticle.urlToImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            randomArticle.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            randomArticle.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

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
                Article randomArticle = snapshot.data as Article;
                return buildArticle(context, randomArticle);

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
