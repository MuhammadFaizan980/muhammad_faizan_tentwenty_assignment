import 'package:floor/floor.dart';

@entity
class Movie {
  @primaryKey
  late final int id;
  late final String name;
  late final String posterImage;
  late final String releaseDate;
  late final bool adult;

  Movie(this.id, this.name, this.posterImage, this.releaseDate, this.adult);
}
