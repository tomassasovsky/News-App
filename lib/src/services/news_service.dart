import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/models/category_model.dart';

final urlNewsApi = 'newsapi.org';
final urlNewsApiKey = '0ce8640820e4441b8415b0651d4625bc';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get getSelectedCategoryArticles => this.categoryArticles[this.selectedCategory];

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

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final path = '/v2/top-headlines';
    final url = Uri.https(
      urlNewsApi,
      path,
      {
        'country': 'ar',
        'apiKey': '$urlNewsApiKey',
        'category': '$category',
      },
    );

    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.categoryArticles[category]!.addAll(newsResponse.articles!);

    notifyListeners();
  }
}
