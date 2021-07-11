import 'package:floor/floor.dart';

@entity
class MovieTicket {
  @primaryKey
  late final int id;
  late final String seatNumber;
  late final String location;
  late final String cinemaName;

  MovieTicket(this.id, this.seatNumber, this.location, this.cinemaName);
}
