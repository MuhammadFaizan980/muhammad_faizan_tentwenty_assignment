import 'package:floor/floor.dart';

@entity
class MovieTicket {
  @primaryKey
  late final int id;
  late final int movieId;
  late final int seatNumber;
  late final String location;
  late final String cinemaName;

  MovieTicket(
      this.id, this.movieId, this.seatNumber, this.location, this.cinemaName);
}
