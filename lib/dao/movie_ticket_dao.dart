import 'package:faizan_tentwenty_assignment/models/movie_ticket.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieTicketDao {
  @Query('SELECT * FROM MovieTicket WHERE id = :id')
  Future<MovieTicket?> getMovieTicket(int id);

  @insert
  Future<void> insertTicket(MovieTicket movieTicket);
}
