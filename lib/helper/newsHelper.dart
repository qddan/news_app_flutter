import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_flutter/config.dart';

import '../models/article_model.dart';

Future<List<ArticleModel>> getNews({int pageSize, int size}) async {
  List<ArticleModel> list = [];
  String url = "$TOP_HEADLINE&country=us&category=business&pgeSize=1&size=3";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData['status'] == 'ok') {
      final articles = jsonData['articles'] as List;
      list = articles.map((e) => ArticleModel.fromJson(e)).toList();
    }
    // If the server did return a 200 OK response,
    // then parse the JSON.

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }

  return list;
}

class NewsForCategorie {
  List<ArticleModel> news = [];

  Future<void> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${API_KEY}";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
