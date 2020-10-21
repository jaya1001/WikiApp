
import 'package:wikipedia_app/database/db_helper.dart';
import 'package:wikipedia_app/fetch_page_service.dart';
import 'package:wikipedia_app/models/page.dart';
import 'package:rxdart/rxdart.dart';


class WikiInfoBloc {

  final _wikiInfoController = BehaviorSubject<List<WikiPage>>();

  Stream<List<WikiPage>> get wikiInfoStream =>
      _wikiInfoController.stream;

  Future fetchWikiInfo(String query) async {
//    List<WikiPage> pages = await DatabaseHelper().getAllWikiPages();
  List<WikiPage> pages = List();
    if (pages == null || pages.isEmpty) {
      pages = await FetchWikiPageService().fetchData(query);
    }
    if(pages == null || pages.isEmpty) {
      _wikiInfoController.add(List());
    } else {
      await _wikiInfoController.add(pages);
    }
    return;
  }

  dispose() {
    _wikiInfoController.close();
  }
}