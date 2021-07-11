import 'package:floor/floor.dart';

@entity
class MovieDetails {
  @primaryKey
  late final int id;
  late final double rating;
  late final String name;
  late final String overview;
  late final String releaseDate;
  late final String trailerYoutubeVideoId;
  late final String encodedImagesList;
  late final String encodedGeneresList;

  MovieDetails(this.id, this.rating, this.name, this.overview, this.releaseDate,
      this.trailerYoutubeVideoId, this.encodedImagesList, this.encodedGeneresList);
}
