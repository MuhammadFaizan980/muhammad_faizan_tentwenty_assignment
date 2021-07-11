import 'dart:async';

import 'package:faizan_tentwenty_assignment/dao/movie_dao.dart';
import 'package:faizan_tentwenty_assignment/dao/movie_details_dao.dart';
import 'package:faizan_tentwenty_assignment/dao/movie_ticket_dao.dart';
import 'package:faizan_tentwenty_assignment/models/movie_details.dart';
import 'package:faizan_tentwenty_assignment/models/movie_ticket.dart';
import 'package:faizan_tentwenty_assignment/models/movie.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Movie, MovieDetails, MovieTicket])
abstract class AppDatabase extends FloorDatabase {
  MoviesDao get moviesDao;

  MovieDetailsDao get movieDetailsDao;

  MovieTicketDao get movieTicketDao;
}
