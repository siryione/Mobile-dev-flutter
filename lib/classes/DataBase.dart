import 'package:flutter_application/classes/Movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'super_db13.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE movies (
          Title TEXT,
          Type TEXT,
          Year  TEXT,
          Poster TEXT,
          imdbID TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE movies_details (
          Title TEXT,
          Type TEXT,
          Year  TEXT,
          Poster TEXT,
          Rated TEXT,
          Released TEXT,
          Runtime TEXT,
          Genre TEXT,
          Director TEXT,
          Writer TEXT,
          Actors TEXT,
          Plot TEXT,
          Language TEXT,
          Country TEXT,
          Awards TEXT,
          imdbRating TEXT,
          imdbVotes TEXT,
          Production TEXT,
          imdbID TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery (
          url TEXT PRIMARY KEY,
          image BLOB
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery_urls (
          url TEXT PRIMARY KEY
        );
        ''');
      },
      version: 1,
    );
  }

  newMovies(List<Movie> movies) async {
    final db = await database;
    Batch batch = db.batch();
    for (Movie movie in movies) {
      batch.insert(
        'movies',
        {
          'Title': movie.title,
          'Type': movie.type,
          'Year': movie.year,
          'Poster': movie.poster != "N/A" ? movie.poster : '',
          'imdbID': movie.imdbID
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  newMovie(Movie movie) async {
    final db = await database;
    await db.insert(
      "movies_details",
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  newPhotoes(List<String> urls) async {
    final db = await database;
    Batch batch = db.batch();
    for (String url in urls) {
      batch.insert(
        'gallery_urls',
        {'url': url},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<String>> getPhotoes() async {
    final db = await database;
    var res = await db.query('gallery_urls');
    return List.generate(res.length, (index) => res[index]['url']);
  }

  Future<List<Movie>> getMovies(String query) async {
    final db = await database;
    var res = await db.query('movies');

    final retu = List.generate(res.length, (index) => Movie.fromMap(res[index]))
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print(retu);
    return retu;
  }

  Future<Movie> getMovie(String id) async {
    if (id == null) {
      return null;
    }
    final db = await database;
    var res = await db.query(
      'movies_details',
      where: "imdbID = ?",
      whereArgs: [id],
    );
    print(res);
    return res.isNotEmpty ? Movie.fromMap(res.first) : null;
  }
}
