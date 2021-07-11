import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:faizan_tentwenty_assignment/dao/movie_details_dao.dart';
import 'package:faizan_tentwenty_assignment/http/my_requests.dart';
import 'package:faizan_tentwenty_assignment/local_db/app_database.dart';
import 'package:faizan_tentwenty_assignment/models/movie_details.dart';
import 'package:faizan_tentwenty_assignment/providers/movie_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MovieDetailsController {
  MovieDetails? _movieDetails;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getMovieDetails(
    BuildContext context,
    String movieDetailsUrl,
    String movieImagesUrl,
    String movieTrailerUrl,
    int movieId,
  ) async {
    Map<String, dynamic> response =
        await MyRequests.getRequest(context, movieDetailsUrl);
    try {
      _movieDetails = MovieDetails(
        response['id'],
        response['vote_average'],
        response['title'],
        response['overview'],
        response['release_date'],
        '',
        '',
        jsonEncode(response['genres']),
      );
      _getImages(context, movieImagesUrl, movieTrailerUrl, movieId);
    } catch (exc) {
      Provider.of<MovieDetailsProvider>(context, listen: false)
          .addMovieDetails(_movieDetails);
    }
  }

  Future<void> _getImages(
    BuildContext context,
    String url,
    String movieTrailerUrl,
    int movieId,
  ) async {
    Map<String, dynamic> response = await MyRequests.getRequest(context, url);
    List imagesList = [];
    try {
      for (var i in response['backdrops']) {
        if (imagesList.length == 5) break;
        imagesList.add(i['file_path']);
      }
      _movieDetails = MovieDetails(
        _movieDetails!.id,
        _movieDetails!.rating,
        _movieDetails!.name,
        _movieDetails!.overview,
        _movieDetails!.releaseDate,
        _movieDetails!.trailerYoutubeVideoId,
        jsonEncode(imagesList),
        _movieDetails!.encodedGeneresList,
      );
      _getTrailerUrls(context, movieTrailerUrl, movieId);
    } catch (exc) {
      Provider.of<MovieDetailsProvider>(context, listen: false)
          .addMovieDetails(_movieDetails);
    }
  }

  Future<void> _getTrailerUrls(
      BuildContext context, String url, int movieId) async {
    Map<String, dynamic> response = await MyRequests.getRequest(context, url);
    print(response['results'][0]['key']);
    try {
      _movieDetails = MovieDetails(
        _movieDetails!.id,
        _movieDetails!.rating,
        _movieDetails!.name,
        _movieDetails!.overview,
        _movieDetails!.releaseDate,
        response['results'][0]['key'],
        _movieDetails!.encodedImagesList,
        _movieDetails!.encodedGeneresList,
      );
      Provider.of<MovieDetailsProvider>(context, listen: false)
          .addMovieDetails(_movieDetails);
      if (_movieDetails != null) _cacheMovies(movieId);
    } catch (exc) {
      Provider.of<MovieDetailsProvider>(context, listen: false)
          .addMovieDetails(_movieDetails);
    }
  }

  Future<void> _cacheMovies(int movieId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    MovieDetailsDao movieDetailsDao = database.movieDetailsDao;
    if (await movieDetailsDao.getMovieDetails(movieId) == null) {
      await movieDetailsDao.insertMovie(_movieDetails!);
    } else {
      var a = await movieDetailsDao.getMovieDetails(movieId);
      print(a!.releaseDate);
    }
  }

  Future<void> getCachedMovies(BuildContext context, int movieId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    MovieDetailsDao movieDetailsDao = database.movieDetailsDao;

    Provider.of<MovieDetailsProvider>(context, listen: false)
        .addMovieDetails(await movieDetailsDao.getMovieDetails(movieId));
  }
}
