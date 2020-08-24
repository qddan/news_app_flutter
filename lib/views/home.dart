import 'package:flutter/material.dart';
import 'package:news_app_flutter/components/Appbar.dart';
import 'package:news_app_flutter/components/category_tile.dart';
import 'package:news_app_flutter/components/newTile.dart';
import 'package:news_app_flutter/helper/data.dart';
import 'package:news_app_flutter/helper/newsHelper.dart';
import 'package:news_app_flutter/models/article_model.dart';
import 'package:news_app_flutter/models/categori_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<ArticleModel>> futureArticles;
  List<CategoryModel> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureArticles = getNews(
      pageSize: 10,
      size: 1,
    );

    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: categories[index].categoryName,
                    imageUrl: categories[index].imageUrl,
                  );
                },
              ),
            ),
            Container(
              child: FutureBuilder<List<ArticleModel>>(
                future: futureArticles,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ArticleModel> newsList = snapshot.data;

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          return NewsTile(
                            imgUrl: newsList[index].urlToImage ?? "",
                            title: newsList[index].title ?? "",
                            desc: newsList[index].description ?? "",
                            content: newsList[index].content ?? "",
                            posturl: newsList[index].url ?? "",
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
