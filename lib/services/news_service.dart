import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/constants/constants.dart';
import 'package:news/models/article_response.dart';

class NewsService {
  static var instance = NewsService._();

  NewsService._();

  Future<ArticleResponse> loadNews({String query = 'a', int page = 1}) async {
    http.Response response = await http.get(_generateUrl(query, page.toString()), headers: {
      'x-api-key': 'b4aa6f395a0d4f46a65cffd321e95b66',
    });
    if (response.statusCode == 200) {
      return ArticleResponse.fromMap(json.decode(response.body));
    } else {
      throw Exception(['failed', response.body.toString()]);
    }
  }
  _generateUrl(String query,String page){
    return Uri.parse(Constants.baseUrl.toString()+'?q=$query&page=$page');
  }
}
