import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faizan_tentwenty_assignment/controllers/movie_details_controller.dart';
import 'package:faizan_tentwenty_assignment/providers/movie_details_provider.dart';
import 'package:faizan_tentwenty_assignment/screens/play_trailer_screen.dart';
import 'package:faizan_tentwenty_assignment/utils/constants.dart';
import 'package:faizan_tentwenty_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  int _movieId;

  MovieDetailsScreen(this._movieId);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsController _movieDetailsController =
      GetIt.I.get<MovieDetailsController>();

  @override
  void initState() {
    _initDateFetch();
    super.initState();
  }

  Future<void> _initDateFetch() async {
    if (await _movieDetailsController.checkInternetConnectivity()) {
      String movieDetailsUrl =
          '$MOVIE_DETAILS/${widget._movieId}?api_key=$API_KEY';
      String movieImagesUrl =
          '$MOVIE_IMAGES/${widget._movieId}/images?api_key=$API_KEY';
      String movieTrailersUrl =
          '$MOVIE_TRAILERS/${widget._movieId}/videos?api_key=$API_KEY';
      _movieDetailsController.getMovieDetails(
        context,
        movieDetailsUrl,
        movieImagesUrl,
        movieTrailersUrl,
        widget._movieId,
      );
    } else {
      _movieDetailsController.getCachedMovieData(context, widget._movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: Consumer<MovieDetailsProvider>(
        builder: (context, movieDetailsProvider, _) {
          if (movieDetailsProvider.isLoading) {
            return Utils.loadingContainer(context);
          } else if (movieDetailsProvider.movieDetails == null) {
            return Utils.errorBody('Error fetching details!');
          } else {
            List imagesList = jsonDecode(
                movieDetailsProvider.movieDetails!.encodedImagesList);
            List genreList = jsonDecode(
                movieDetailsProvider.movieDetails!.encodedGeneresList);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1.0,
                    ),
                    items: imagesList.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return CachedNetworkImage(
                            imageUrl: '$BASE_POSTER_IMAGE_URL/$imagePath',
                            width: Utils.getScreenWidth(context),
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                JumpingDotsProgressIndicator(
                                  fontSize: 32.0,
                                  color: Colors.blue,
                                ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      movieDetailsProvider.movieDetails!.name,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      movieDetailsProvider.movieDetails!.releaseDate,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Wrap(
                      children: genreList
                          .map(
                            (e) => Utils.getOutlineBox(e['name']),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 4),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          rating: movieDetailsProvider.movieDetails!.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                          ),
                          itemCount: 10,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '(${movieDetailsProvider.movieDetails!.rating})',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: Text(
                      movieDetailsProvider.movieDetails!.overview,
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: TextButton(
                      onPressed: () {
                        Utils.push(
                          context,
                          PlayTrailerScreen(movieDetailsProvider
                              .movieDetails!.trailerYoutubeVideoId),
                        );
                      },
                      child: Text(
                        'Watch Trailer',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
