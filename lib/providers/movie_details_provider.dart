import 'package:faizan_tentwenty_assignment/models/movie_details.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailsProvider extends ChangeNotifier {
  MovieDetails? movieDetails;
  bool isLoading = true;

  void addMovieDetails(MovieDetails? movieDetails) {
    this.movieDetails = movieDetails;
    isLoading = false;
    notifyListeners();
  }
}
