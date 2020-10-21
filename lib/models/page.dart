
import 'package:wikipedia_app/models/terms.dart';
import 'package:wikipedia_app/models/thumbnail.dart';

class WikiPage {
  
  int _pageId;
  int _ns;
  String _title;
  int _index;
  Thumbnail _thumbnail;
  Terms _terms;

  WikiPage(this._pageId, this._ns, this._title, this._index, this._thumbnail,
      this._terms);

  Terms get terms => _terms;

  set terms(Terms value) {
    _terms = value;
  }

  Thumbnail get thumbnail => _thumbnail;

  set thumbnail(Thumbnail value) {
    _thumbnail = value;
  }

  int get index => _index;

  set index(int value) {
    _index = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get ns => _ns;

  set ns(int value) {
    _ns = value;
  }

  int get pageId => _pageId;

  set pageId(int value) {
    _pageId = value;
  }

  WikiPage.fromJson(Map<String, dynamic> json) {
    pageId = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    index = json['index'];
    if(json['thumbnail'] != null && json['thumbnail'].toString().isNotEmpty){
      thumbnail = Thumbnail.fromJson(json['thumbnail']);
    }
    if(json['terms'] != null && json['terms'].toString().isNotEmpty){
      terms = Terms.fromJson(json['terms']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageid'] = pageId;
    data['ns'] = ns;
    data['title'] = title;
    data['index'] = index;
    if(thumbnail != null) {
      data['thumbnail'] = thumbnail.toJson();
    }
    if(terms != null) {
      data['terms'] = terms.toJson();
    }
    return data;
  }
}