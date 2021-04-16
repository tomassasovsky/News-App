import 'package:flutter/material.dart';
import 'package:newsapp/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/src/services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: newsService.headlines.length == 0 ? Center(child: CircularProgressIndicator()) : ListNews(newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
