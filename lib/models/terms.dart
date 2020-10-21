
class Terms {
  List<String> _description;
  List<String> _label;
  List<String> _alias;

  Terms(this._description, this._label, this._alias);

  List<String> get description => _description;

  set description(List<String> value) {
    _description = value;
  }


  List<String> get label => _label;

  set label(List<String> value) {
    _label = value;
  }

  Terms.fromJson(Map<String, dynamic> json) {
    description = List();
    if(json['description'] != null && json['description'] != '') {
      json['description'].forEach((v) {
        if(v != null) {
          description.add(v);
        }
      });
    }
    alias = List();
    if(json['alias'] != null && json['alias'] != '') {
      json['alias'].forEach((v) {
        if(v != null) {
          alias.add(v);
        }
      });
    }
    label = List();
    if(json['label'] != null && json['label'] != '') {
      json['label'].forEach((v) {
        if(v != null) {
          label.add(v);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = List();
    data['alias'] = List();
    data['label'] = List();
    data['description'] = description.map((v) => v).toList();
    data['alias'] = alias.map((v) => v).toList();
    data['label'] = label.map((v) => v).toList();
    return data;
  }

  List<String> get alias => _alias;

  set alias(List<String> value) {
    _alias = value;
  }
}

