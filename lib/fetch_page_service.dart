import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:wikipedia_app/models/page.dart';
import 'package:wikipedia_app/ui/theme.dart';

class FetchWikiPageService {

  FetchWikiPageService();

  Future<List<WikiPage>> fetchData(String query) async {

    final response = await http.get("https://en.wikipedia.org/w/api.php?"
        "format=json&action=query&formatversion=2&generator=prefixsearch&gpssearch=$query"
        "&gpslimit=10&prop=pageimages|pageterms&piprop=thumbnail");

    if (response == null ||
        response.statusCode != 200 ||
        response.body == null) {
      // log error

      throw new Exception("No response from server...!!!");
    }
    int code = response.statusCode;
    print("response from wiki api ${response.body}");
    String content;
    if (code == 200) {
      if (content == "{}") {
      } else {
        List<dynamic> pagesJson = jsonDecode(response.body)['query']['pages'];
        List<WikiPage> pages = List();
        if(pagesJson != null && pagesJson.isNotEmpty) {
          pagesJson.forEach((element) {
            WikiPage page = new WikiPage.fromJson(element);
            pages.add(page);
            print("page is ${page}");
          });
        }
        return pages;
      }
    } else {
      // log error and exception
      throw new Exception("Unable to get information for searched query...!!!");
    }
    return null;
  }
}