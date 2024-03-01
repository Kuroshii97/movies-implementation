class Caption {
  Caption({
      this.plainText, 
      this.typename,});

  Caption.fromJson(dynamic json) {
    plainText = json['plainText'];
    typename = json['__typename'];
  }
  String? plainText;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plainText'] = plainText;
    map['__typename'] = typename;
    return map;
  }

}