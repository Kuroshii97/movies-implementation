import 'movie.dart';

class MovieResponse {
  MovieResponse({
      this.page, 
      this.next, 
      this.entries, 
      this.results,});

  MovieResponse.fromJson(dynamic json) {
    page = json['page'];
    next = json['next'];
    entries = json['entries'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Movie.fromJson(v));
      });
    }
  }
  num? page;
  String? next;
  num? entries;
  List<Movie>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['next'] = next;
    map['entries'] = entries;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}