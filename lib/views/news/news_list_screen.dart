import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:news/models/article_response.dart';
import 'package:news/services/news_service.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'news_card.dart';
import 'news_details/news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  final hasSearch;

  const NewsScreen({Key? key, this.hasSearch}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late PagingController<int, Article> _pagingController;
  var isFinished;
  var _searchController;
  final dateFormatter = new DateFormat('yyyy-MM-dd hh:mm');
  late List<Article> _readablesArticles;

  late String _searchQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getReadables();
    _searchController = new TextEditingController();
    _searchQuery = 'a';
    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      _loadData(pageKey);
    });
  }

  Future _getReadables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strings = prefs.getStringList('readAbles');
    if (strings != null)
      _readablesArticles =
          strings.map<Article>((e) => Article.fromJson(e)).toList();
    else
      _readablesArticles = [];
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              widget.hasSearch
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 200,
                            child: TextField(
                              onSubmitted: (v) {
                                setState(() {
                                  _pagingController =
                                      new PagingController(firstPageKey: 1);
                                });
                                if (_searchQuery.isEmpty) _searchQuery = 'a';
                                _loadData(1);
                              },
                              onChanged: (v) {
                                _searchQuery = v;
                              },
                              controller: _searchController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                          width: 100,
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: PagedListView<int, Article>(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<Article>(
                        itemBuilder: (context, item, index) => Container(
                          foregroundDecoration: _readablesArticles.contains(item)? RotatedCornerDecoration(
                            color: Colors.green,
                            geometry: const BadgeGeometry(width: 90, height: 90),
                            textSpan: const TextSpan(
                              text: 'Readable',
                              style: TextStyle(fontSize: 16, color: Colors.white,backgroundColor: Colors.green),
                            ),
                            labelInsets: const LabelInsets(baselineShift: 0),):null,
                          child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              NewsDetailsScreen(article: item))),
                                  child: NewsCard(
                                    titleText: item.title,
                                    subText: Container(
                                      child: Row(children: [
                                        Container(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(item.author.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 12)),
                                        ),
                                        Text(dateFormatter.format(item.publishedAt),
                                            style: TextStyle(color: Colors.teal))
                                      ]),
                                    ),
                                    midContent: CachedNetworkImage(
                                      imageUrl: item.urlToImage,
                                      height:
                                          MediaQuery.of(context).size.width * 0.6,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    buttonText: 'Show Details',
                                    cardTheme: Colors.indigo,
                                    buttonFunction: () {},
                                    cardBackgroundColor: Colors.white,
                                  ),
                                ),
                        ),
                            ))),
            ],
          ),
        ),
      ),
    );
  }

  void _loadData(int pageKey) {
    NewsService.instance
        .loadNews(page: pageKey, query: _searchQuery)
        .then((value) => _addData(value, pageKey + 1));
  }

  _addData(ArticleResponse value, int nextPageKey) {
    _pagingController.appendPage(value.articles, nextPageKey);
  }
}
