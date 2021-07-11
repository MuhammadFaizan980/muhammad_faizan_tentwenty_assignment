import 'package:faizan_tentwenty_assignment/models/movie_details.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDetailsDao {

  @Query('SELECT * FROM MovieDetails WHERE id = :id')
  Future<MovieDetails?> getMovieDetails(int id);

  @insert
  Future<void> insertMovie(MovieDetails movieDetails);
}
