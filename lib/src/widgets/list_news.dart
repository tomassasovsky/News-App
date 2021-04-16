import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;
  const ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (context, index) {
        return _New(news: this.news[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article? news;
  final int? index;

  const _New({Key? key, @required this.news, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(this.news, this.index),
        _TitleCard(this.news),
        _ImageCard(this.news),
        _BodyCard(this.news),
        SizedBox(height: 10),
        Divider(),
        _ButtonsCard(),
      ],
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: theme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article? news;
  _ImageCard(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (news!.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(news!.urlToImage!),
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article? news;
  _BodyCard(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(news!.description != null ? news!.description! : ''),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article? news;
  _TitleCard(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(news!.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article? news;
  final int? index;
  const _TopBarCard(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index! + 1}. ', style: TextStyle(color: theme.accentColor)),
          Text('${news!.source!.name}. '),
        ],
      ),
    );
  }
}
