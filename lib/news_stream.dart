import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fudeo_start_stream_app/article.dart';
import 'package:fudeo_start_stream_app/config.dart';
import 'package:http/http.dart' as http;

class NewsStream {
  StreamController<Article> controller;
  Timer timer;

  /// Inizializzazione della class [NewsStream].
  NewsStream() {
    this.controller = StreamController(
      /// Funzioni di callback dello stream.
      onListen: startStream,
      onCancel: closeStream,
      onResume: startStream,
      onPause: closeStream,
    );
  }

  Stream<Article> getStream() {
    return controller.stream;
  }

  void startStream() {
    print("Start Stream");
    timer = Timer.periodic(Duration(seconds: 5), produce);
  }

  void closeStream() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }

    /// Il [?] davanti a [timer] ci permette di eseguire il metodo [.cancel()]
    /// solo se [timer] è diverso da [null], così da evitare l'errore [NullPointerException].
    ///
    /// timer?.cancel();
    /// timer = null;
  }

  void produce(_) async {
    final apiKey = Config().apiKey;

    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?sources=ansa&apiKey=$apiKey"));
    List articlesList = json.decode(response.body)["articles"];

    final articles = articlesList.map((data) => Article.fromData(data)).toList();

    final randomArticleIndex = Random().nextInt(articles.length);
    final randomArticle = articles[randomArticleIndex];

    /// Aggiungo un [Article] casualmente, dalla List [articles], allo stream [NewsStream].
    controller.add(randomArticle);
  }
}
