class ReleaseYear {
  ReleaseYear({
      this.year, 
      this.endYear, 
      this.typename,});

  ReleaseYear.fromJson(dynamic json) {
    year = json['year'];
    endYear = json['endYear'];
    typename = json['__typename'];
  }
  num? year;
  dynamic endYear;
  String? typename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['endYear'] = endYear;
    map['__typename'] = typename;
    return map;
  }

}