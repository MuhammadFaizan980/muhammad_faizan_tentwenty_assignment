import 'package:faizan_tentwenty_assignment/models/movie.dart';
import 'package:floor/floor.dart';

@dao
abstract class MoviesDao {


  @Query('DELETE FROM Movie')
  Future<void> clearMovieTable();

  @Query('SELECT * FROM Movie')
  Future<List<Movie>?> getAllMovies();

  @insert
  Future<void> insertMovie(Movie movie);
}
