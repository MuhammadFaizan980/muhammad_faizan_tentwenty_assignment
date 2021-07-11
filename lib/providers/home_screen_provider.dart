import 'package:faizan_tentwenty_assignment/models/movie.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<Movie> moviesList = [];
  bool isLoading = true;

  void addMovies(List<Movie> moviesList) {
    this.moviesList = moviesList;
    isLoading = false;
    notifyListeners();
  }
}
