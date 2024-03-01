import 'package:movies_application/model/movie.dart';
import 'package:movies_application/network/network_provider.dart';

class Repository {
  final _networkProvider = NetworkProvider();

  Future<List<Movie>> getMovieList() async {
    final response = await _networkProvider.getMoviesList();
    List<Movie> movieList = [];
    for (int i = 0; i < response['results'].length; i++) {
      movieList.add(Movie.fromJson(response['results'][i]));
    }
    return movieList;
  }

  Future<List<Movie>> getActionMovieList() async {
    final response = await _networkProvider.getActionMoviesList();
    List<Movie> movieList = [];
    for (int i = 0; i < response['results'].length; i++) {
      movieList.add(Movie.fromJson(response['results'][i]));
    }
    return movieList;
  }

  Future<List<Movie>> searchMovieByName(String movieName) async {
    final response = await _networkProvider.searchMovieByName(movieName);
    List<Movie> movieList = [];
    for (int i = 0; i < response['results'].length; i++) {
      movieList.add(Movie.fromJson(response['results'][i]));
    }
    return movieList;
  }

  Future<Movie> selectMovieDetailById(String id) async {
    final response = await _networkProvider.selectMovieDetailById(id);
    return Movie.fromJson(response['results']);
  }

}
