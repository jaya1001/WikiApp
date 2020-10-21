
class Thumbnail {

  String _source;
  int _width;
  int _height;

  Thumbnail(this._source, this._width, this._height);

  int get height => _height;

  set height(int value) {
    _height = value;
  }

  int get width => _width;

  set width(int value) {
    _width = value;
  }

  String get source => _source;

  set source(String value) {
    _source = value;
  }

  Thumbnail.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = width;
    data['height'] = height;
    data['source'] = source;
    return data;
  }
}