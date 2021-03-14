import 'package:flutter/material.dart';

class Article {
  String title;
  String description;
  String content;
  String url;
  String urlToImage;

  Article({
    @required this.title,
    @required this.description,
    @required this.content,
    @required this.url,
    @required this.urlToImage,
  });

  factory Article.fromData(dynamic data) {
    String title = data["title"];
    String description = data["description"];
    String content = data["content"];
    String url = data["url"];
    String urlToImage = data["urlToImage"];

    return Article(
      title: title,
      description: description,
      content: content,
      url: url,
      urlToImage: urlToImage,
    );
  }
}
