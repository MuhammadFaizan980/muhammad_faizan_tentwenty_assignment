import 'package:connectivity/connectivity.dart';
import 'package:faizan_tentwenty_assignment/dao/movie_dao.dart';
import 'package:faizan_tentwenty_assignment/http/my_requests.dart';
import 'package:faizan_tentwenty_assignment/local_db/app_database.dart';
import 'package:faizan_tentwenty_assignment/models/movie.dart';
import 'package:faizan_tentwenty_assignment/providers/home_screen_provider.dart';
import 'package:faizan_tentwenty_assignment/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreenController {
  bool _connectivityResult = false;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _connectivityResult = true;
      return true;
    } else {
      return false;
    }
  }

  Future<void> getMovies(BuildContext context) async {
    String url = '$ALL_MOVIES?api_key=$API_KEY';
    Map<String, dynamic> response =
        await MyRequests.getRequest(context, url) ?? {};
    List<Movie> moviesList = [];
    try {
      for (var i in response['results']) {
        Movie movie = Movie(i['id'], i['title'], i['poster_path'],
            i['release_date'], i['adult']);
        moviesList.add(movie);
      }
      Provider.of<HomeScreenProvider>(context, listen: false)
          .addMovies(moviesList);
      if (moviesList.isNotEmpty) _cachedMovies(moviesList);
    } catch (e) {
      Provider.of<HomeScreenProvider>(context, listen: false)
          .addMovies(moviesList);
    }
  }

  Future<void> _cachedMovies(List<Movie> moviesList) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    MoviesDao moviesDao = database.moviesDao;
    await moviesDao.clearMovieTable();
    for (Movie i in moviesList) {
      await moviesDao.insertMovie(i);
    }
  }

  Future<void> getCachedMovies(BuildContext context) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    MoviesDao moviesDao = database.moviesDao;
    List<Movie> moviesList = await moviesDao.getAllMovies() ?? [];
    Provider.of<HomeScreenProvider>(context, listen: false)
        .addMovies(moviesList);
  }
}
