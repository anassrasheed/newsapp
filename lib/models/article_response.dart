import 'dart:convert';

class ArticleResponse {
  ArticleResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  ArticleResponse copyWith({
    required String status,
    required int totalResults,
    required List<Article> articles,
  }) =>
      ArticleResponse(
        status: status,
        totalResults: totalResults,
        articles: articles,
      );

  factory ArticleResponse.fromJson(String str) => ArticleResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleResponse.fromMap(Map<String, dynamic> json) => ArticleResponse(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
  };
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  Article copyWith({
    required Source source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required DateTime publishedAt,
    required String content,
  }) =>
      Article(
        source: source,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    source: Source.fromMap(json["source"]),
    author: json["author"]??'UnKnown',
    title: json["title"]?? 'Article',
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"]??'https',
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "source": source.toMap(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    if(!(other is Article))
      return false;
    Article otherCast=other;
    return super == other||(
    this.content==otherCast.content&&
    this.author==otherCast.author&&
    this.title==otherCast.title&&
    this.description==otherCast.description&&
    this.publishedAt==otherCast.publishedAt&&
    this.urlToImage==otherCast.urlToImage
    );
  }

  @override
  int get hashCode => super.hashCode;

}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Source copyWith({
    required String id,
    required String name,
  }) =>
      Source(
        id: id,
        name: name,
      );

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) => Source(
    id: json["id"] == null ? '': json["id"] ,
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id ,
    "name": name,
  };
}



class EnumValues<T> {
  Map<String, T> map={};
  Map<T, String> reverseMap={};

  EnumValues(this.map);

  Map<T, String> get reverse {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}
