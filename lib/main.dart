import 'package:faizan_tentwenty_assignment/controllers/home_screen_controller.dart';
import 'package:faizan_tentwenty_assignment/controllers/ticket_controller.dart';
import 'package:faizan_tentwenty_assignment/providers/home_screen_provider.dart';
import 'package:faizan_tentwenty_assignment/providers/movie_details_provider.dart';
import 'package:faizan_tentwenty_assignment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'controllers/movie_details_controller.dart';

main() {
  GetIt.I.registerLazySingleton<HomeScreenController>(
      () => HomeScreenController());
  GetIt.I.registerLazySingleton<MovieDetailsController>(
      () => MovieDetailsController());
  GetIt.I.registerLazySingleton<TicketController>(() => TicketController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieDetailsProvider(),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
