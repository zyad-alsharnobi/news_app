import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio dio;
  NewsService(this.dio);

  Future<List<ArticleModel>> GetNews({required String category}) async {
    try {
      Response response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=b853ff1424c34ae7baa13920716dc7d1&category=$category');
      Map<String, dynamic> JsonData = response.data;
      List<dynamic> articles = JsonData['articles'];
      List<ArticleModel> articleslist = [];
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel(
            image: article["urlToImage"],
            title: article["title"],
            subtitle: article["description"]);
        articleslist.add(articleModel);
      }
      return articleslist;
    } catch (e) {
      return [];
    }
  }
}
