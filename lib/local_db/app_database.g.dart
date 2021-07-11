// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MoviesDao? _moviesDaoInstance;

  MovieDetailsDao? _movieDetailsDaoInstance;

  MovieTicketDao? _movieTicketDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `posterImage` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `adult` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieDetails` (`id` INTEGER NOT NULL, `rating` REAL NOT NULL, `name` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `trailerYoutubeVideoId` TEXT NOT NULL, `encodedImagesList` TEXT NOT NULL, `encodedGeneresList` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieTicket` (`id` INTEGER NOT NULL, `movieId` INTEGER NOT NULL, `seatNumber` INTEGER NOT NULL, `location` TEXT NOT NULL, `cinemaName` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MoviesDao get moviesDao {
    return _moviesDaoInstance ??= _$MoviesDao(database, changeListener);
  }

  @override
  MovieDetailsDao get movieDetailsDao {
    return _movieDetailsDaoInstance ??=
        _$MovieDetailsDao(database, changeListener);
  }

  @override
  MovieTicketDao get movieTicketDao {
    return _movieTicketDaoInstance ??=
        _$MovieTicketDao(database, changeListener);
  }
}

class _$MoviesDao extends MoviesDao {
  _$MoviesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'posterImage': item.posterImage,
                  'releaseDate': item.releaseDate,
                  'adult': item.adult ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<void> clearMovieTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Movie');
  }

  @override
  Future<List<Movie>?> getAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            row['id'] as int,
            row['name'] as String,
            row['posterImage'] as String,
            row['releaseDate'] as String,
            (row['adult'] as int) != 0));
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }
}

class _$MovieDetailsDao extends MovieDetailsDao {
  _$MovieDetailsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieDetailsInsertionAdapter = InsertionAdapter(
            database,
            'MovieDetails',
            (MovieDetails item) => <String, Object?>{
                  'id': item.id,
                  'rating': item.rating,
                  'name': item.name,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'trailerYoutubeVideoId': item.trailerYoutubeVideoId,
                  'encodedImagesList': item.encodedImagesList,
                  'encodedGeneresList': item.encodedGeneresList
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieDetails> _movieDetailsInsertionAdapter;

  @override
  Future<MovieDetails?> getMovieDetails(int id) async {
    return _queryAdapter.query('SELECT * FROM MovieDetails WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieDetails(
            row['id'] as int,
            row['rating'] as double,
            row['name'] as String,
            row['overview'] as String,
            row['releaseDate'] as String,
            row['trailerYoutubeVideoId'] as String,
            row['encodedImagesList'] as String,
            row['encodedGeneresList'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertMovie(MovieDetails movieDetails) async {
    await _movieDetailsInsertionAdapter.insert(
        movieDetails, OnConflictStrategy.abort);
  }
}

class _$MovieTicketDao extends MovieTicketDao {
  _$MovieTicketDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _movieTicketInsertionAdapter = InsertionAdapter(
            database,
            'MovieTicket',
            (MovieTicket item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'seatNumber': item.seatNumber,
                  'location': item.location,
                  'cinemaName': item.cinemaName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieTicket> _movieTicketInsertionAdapter;

  @override
  Future<MovieTicket?> getMovieTicket(int id) async {
    return _queryAdapter.query('SELECT * FROM MovieTicket WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieTicket(
            row['id'] as int,
            row['movieId'] as int,
            row['seatNumber'] as int,
            row['location'] as String,
            row['cinemaName'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertTicket(MovieTicket movieTicket) async {
    await _movieTicketInsertionAdapter.insert(
        movieTicket, OnConflictStrategy.abort);
  }
}
