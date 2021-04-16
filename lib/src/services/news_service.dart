import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final urlNewsApi = 'newsapi.org';
final urlNewsApiKey = '0ce8640820e4441b8415b0651d4625bc';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    final path = '/v2/top-headlines';
    final url = Uri.https(
      urlNewsApi,
      path,
      {
        'country': 'ar',
        'apiKey': '$urlNewsApiKey',
      },
    );
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.headlines.addAll(newsResponse.articles!);
    notifyListeners();
  }
}
