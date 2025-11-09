import 'package:flutter_test/flutter_test.dart';
import 'package:lab2nd/api/NewsApiCall.dart';
import 'package:lab2nd/model/newsapi.dart';

void main() {
  test("News API call returns data", () async {
    newsapi? data = await NewsApiCall().getnewsdata();
    final article1 = data?.articles![0];
    final article2 = data?.articles![99];

    print(article1?.title);
    print(article2?.title);
    print(article2?.author);

    expect(data, isNotNull);
    expect(data!.articles, isNotEmpty);
  });
}
