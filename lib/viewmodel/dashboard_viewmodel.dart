import 'package:flutter/material.dart';
import 'package:movies_application/model/movie.dart';
import 'package:movies_application/network/repository.dart';

class DashboardViewModel extends ChangeNotifier {
  final Repository _repository = Repository();
  List<Movie> movieList = [];
  List<Movie> featuredMovies = [];
  List<Movie> actionMovieList = [];
  List<Movie> searchedMovies = [];
  Movie movie = Movie();
  int position = 0;

  void getMovieForDashboard() async {
    movieList = await _repository.getMovieList();
    for (int i = 0; i < movieList.length; i++){
      if(featuredMovies.length < 4){
        featuredMovies.add(movieList[i]);
      }
    }
    actionMovieList = await _repository.getActionMovieList();
    notifyListeners();
  }

  void searchMovie(String movieName) async {
    try {
      searchedMovies.clear();
      searchedMovies = await _repository.searchMovieByName(movieName);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void selectMovieDetails(Movie selectedMovie) {
    movie = selectedMovie;
    notifyListeners();
  }

  void updatePosition(int position){
    this.position = position;
    notifyListeners();
  }

}