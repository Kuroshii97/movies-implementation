class TitleText {
  TitleText({
      this.text, 
      this.typename,});

  TitleText.fromJson(dynamic json) {
    text = json['text'];
    typename = json['__typename'];
  }
  String? text;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['__typename'] = typename;
    return map;
  }

}