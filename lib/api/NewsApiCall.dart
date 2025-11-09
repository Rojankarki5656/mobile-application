import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:lab2nd/core/static.dart';

import '../model/newsapi.dart';

class NewsApiCall{
  Future<newsapi?> getnewsdata() async {
    try{
      var url = Uri.https(StaticValue.baseUrl, StaticValue.path,
      {
        'q': 'tesla',
        'from': '2025-10-24',
        'sortBy': 'publishedBy',
        'apikey': StaticValue.apikey
      }
      );
      var response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cache-Control': 'no-cache, private, no-store'
      });
      if(response.statusCode.toString().contains('20')){
        var jsondata = await convert.jsonDecode(response.body);
        var data = newsapi.fromJson(jsondata);
        return data;
      }

    }catch (e){
      print('Error msg ${e.toString()}.');
      return null;
    }
  }
}