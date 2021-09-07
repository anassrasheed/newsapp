
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/article_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Article article;

  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final dateFormatter = new DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: ()  =>
               _saveArticleToPrefs('favs'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              label: Text(
                'Add To Favourites',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.star),
            ),
            SizedBox(
              width: 40,
            ),
            TextButton.icon(
              onPressed: () =>
                 _saveArticleToPrefs('readAbles'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
                onSurface: Colors.grey,
              ),
              label: Text(
                'Mark As Readable',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.bookmark_border),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: [
              _getImage(context),
              _getAttributeValueWidget('Title', widget.article.title),
              _getAttributeValueWidget('Published At',
                  dateFormatter.format(widget.article.publishedAt)),
              _getAttributeValueWidget('Author', widget.article.author),
              _getAttributeValueWidget(
                  'Description', widget.article.description),
              _getAttributeValueWidget('Content', widget.article.content),
            ],
          ),
        ),
      ),
    );
  }

  Future _saveArticleToPrefs(String prefName) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var strings = prefs.getStringList(prefName);
    List<Article> articles ;
    if(strings!=null)
      articles=
          strings.map<Article>((e) => Article.fromJson(e)).toList();
    else
      articles =[];
    if(!articles.contains(widget.article))
    articles.add(widget.article);
    
    prefs.setStringList(
        prefName, articles.map<String>((e) => e.toJson()).toList());
                 
  }

  Padding _getAttributeValueWidget(String attribute, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            attribute,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            maxLines: 1000,
          )
        ],
      ),
    );
  }

  CachedNetworkImage _getImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.article.urlToImage,
      height: MediaQuery.of(context).size.width * 0.6,
      fit: BoxFit.fitHeight,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
