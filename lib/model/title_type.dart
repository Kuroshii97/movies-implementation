class TitleType {
  TitleType({
      this.text, 
      this.id, 
      this.isSeries, 
      this.isEpisode, 
      this.typename,});

  TitleType.fromJson(dynamic json) {
    text = json['text'];
    id = json['id'];
    isSeries = json['isSeries'];
    isEpisode = json['isEpisode'];
    typename = json['__typename'];
  }
  String? text;
  String? id;
  bool? isSeries;
  bool? isEpisode;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['id'] = id;
    map['isSeries'] = isSeries;
    map['isEpisode'] = isEpisode;
    map['__typename'] = typename;
    return map;
  }

}