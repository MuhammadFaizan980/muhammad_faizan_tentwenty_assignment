import 'package:cached_network_image/cached_network_image.dart';
import 'package:faizan_tentwenty_assignment/contracts/i_ticket_booked.dart';
import 'package:faizan_tentwenty_assignment/controllers/home_screen_controller.dart';
import 'package:faizan_tentwenty_assignment/models/movie.dart';
import 'package:faizan_tentwenty_assignment/providers/home_screen_provider.dart';
import 'package:faizan_tentwenty_assignment/screens/movie_details_screen.dart';
import 'package:faizan_tentwenty_assignment/utils/constants.dart';
import 'package:faizan_tentwenty_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'book_ticket_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements ITicketBooked {
  final HomeScreenController _homeScreenController =
      GetIt.I.get<HomeScreenController>();
  late int _movieId;

  @override
  void initState() {
    _initFetchProcess();
    super.initState();
  }

  Future<void> _initFetchProcess() async {
    if (await _homeScreenController.checkInternetConnectivity()) {
      _homeScreenController.getMovies(context);
    } else {
      _homeScreenController.getCachedMovies(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muhammad Faizan TenTwenty App'),
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: Consumer<HomeScreenProvider>(
        builder: (context, homeScreenProvider, _) {
          bool isLoading = homeScreenProvider.isLoading;
          if (isLoading) {
            return Utils.loadingContainer(context);
          } else if (homeScreenProvider.moviesList.isEmpty) {
            return Utils.errorBody('No Movie Found');
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(32),
              itemCount: homeScreenProvider.moviesList.length,
              itemBuilder: (context, position) =>
                  _rowDesign(homeScreenProvider, position),
            );
          }
        },
      ),
    );
  }

  Widget _rowDesign(HomeScreenProvider homeScreenProvider, int position) {
    Movie movie = homeScreenProvider.moviesList[position];
    return InkWell(
      onTap: () {
        Utils.push(context, MovieDetailsScreen(movie.id));
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: '$BASE_POSTER_IMAGE_URL${movie.posterImage}',
                  width: 65,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        movie.releaseDate,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Utils.getAdultLabel(
                        adult: movie.adult,
                      ),
                    ],
                  ),
                ),
                FutureBuilder<bool>(
                  future: Utils.booked(movie.id),
                  builder: (context, snapshot) {
                    return SizedBox(
                      width:
                          snapshot.connectionState == ConnectionState.waiting ||
                                  snapshot.data == null ||
                                  snapshot.data as bool
                              ? 0
                              : 80,
                      child: TextButton(
                        onPressed: () {
                          Utils.push(context, BookTicketScreen(this, movie.id));
                        },
                        child: Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onTicketBooked() {
    setState(() {});
  }
}
