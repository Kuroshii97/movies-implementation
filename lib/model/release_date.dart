class ReleaseDate {
  ReleaseDate({
      this.day, 
      this.month, 
      this.year, 
      this.typename,});

  ReleaseDate.fromJson(dynamic json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
    typename = json['__typename'];
  }
  num? day;
  num? month;
  num? year;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['month'] = month;
    map['year'] = year;
    map['__typename'] = typename;
    return map;
  }

}