import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/newslistview.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});
  final String category;
  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  /* List<ArticleModel> articles = [];
   bool isloading = true;
   void initState() {
    super.initState();
    GetGeneralNews();
  }

  Future<void> GetGeneralNews() async {
    articles = await NewsService(Dio()).GetNews();
    isloading = false;
    setState(() {});
  } */
  final spinkit = SpinKitCubeGrid(
    itemBuilder: (context, index) {
      return DecoratedBox(
          decoration:
              BoxDecoration(color: index.isEven ? Colors.black : Colors.red));
    },
    size: 100,
  );
  var future;
  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).GetNews(category: widget.category);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
        future: future,
        builder: (context, Snapshot) {
          if (Snapshot.hasData) {
            return NewsListView(
              articles: Snapshot.data!,
            );
          } else if (Snapshot.hasError) {
            return  const SliverFillRemaining(
                child:  Center(
                  child: Text(
                    'oops there was an error! :(',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
          }
          else {
            return SliverFillRemaining(child: spinkit);
          }
          
        });
    /* isloading
        ? SliverFillRemaining(child: spinkit)
        : articles.isNotEmpty
            ? NewsListView(
                articles: articles,
              )
            : const SliverFillRemaining(
                child:  Center(
                  child: Text(
                    'oops there was an error! :(',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ); */
  }
}
