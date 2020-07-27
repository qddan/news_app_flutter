import 'dart:convert';
import 'package:news_app_flutter/models/article_model.dart';
import 'package:news_app_flutter/views/article_view.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleView> news = new List<ArticleView>();

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f1bee6ef9c1b4806aa9db507bdb3cc2f";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] && element['description']) {
          // ArticleModel
        }
      });
    }
  }
}
