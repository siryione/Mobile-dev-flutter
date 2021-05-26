import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_application/classes/DataBase.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String imdbRating;
  final String imdbVotes;
  final String production;
  final String imdbID;
  final String type;
  final String poster;
  const Movie({
    @required this.title,
    @required this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.imdbRating,
    this.imdbVotes,
    this.production,
    this.imdbID,
    @required this.type,
    @required this.poster,
  });
  //Movie.fromJson(Map<String, dynamic> json)
  //    : title = json['Title'],
  //      year = json['Year'],
  //      poster = json['Poster'],
  //      rated = json['Rated'],
  //      released = json['Released'],
  //      runtime = json['Runtime'],
  //      genre = json['Genre'],
  //      director = json['Director'],
  //      writer = json['Writer'],
  //      actors = json['Actors'],
  //      plot = json['Plot'],
  //      language = json['Language'],
  //      country = json['Country'],
  //      awards = json['Awards'],
  //      imdbRating = json['imdbRating'],
  //      imdbVotes = json['imdbVotes'],
  //      imdbID = json['imdbID'],
  //      type = json['Type'],
  //      production = json['Production'];

  String toString() {
    return 'Movie:{title:$title, year: $year, poster: $poster,type:$type}';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'poster': poster,
      'rated': rated,
      'released': released,
      'runtime ': runtime,
      'genre': genre,
      'director': director,
      'writer': writer,
      'actors': actors,
      'plot ': plot,
      'language': language,
      'country': country,
      'awards': awards,
      'imdbRating': imdbRating,
      'imdbVotes ': imdbVotes,
      'imdbID': imdbID,
      'type': type,
      'production': production,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['Title'],
      year: map['Year'],
      type: map['Type'],
      poster: map['Poster'] != "N/A" ? map['Poster'] : null,
      rated: map['Rated'] == null ? '' : map['Rated'],
      released: map['Released'] == null ? '' : map['Released'],
      runtime: map['Runtime'] == null ? '' : map['Runtime'],
      genre: map['Genre'] == null ? '' : map['Genre'],
      director: map['Director'] == null ? '' : map['Director'],
      writer: map['Writer'] == null ? '' : map['Writer'],
      actors: map['Actors'] == null ? '' : map['Actors'],
      plot: map['Plot'] == null ? '' : map['Plot'],
      language: map['Language'] == null ? '' : map['Language'],
      country: map['Country'] == null ? '' : map['Country'],
      awards: map['Awards'] == null ? '' : map['Awards'],
      imdbRating: map['imdbRating'] == null ? '' : map['imdbRating'],
      imdbVotes: map['imdbVotes'] == null ? '' : map['imdbVotes'],
      imdbID: map['imdbID'] == null ? '' : map['imdbID'],
      production: map['Production'] == null ? '' : map['Production'],
    );
  }

  String toJson() => json.encode(toMap());
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}

class MoviesRead implements MovieService {
  static List<Movie> movies = [];
  @override
  Future<List<Movie>> getMovies(String query) async {
    try {
      var data;
      dynamic jsonMovies;
      if (query.length > 3) {
        data = await http.get(Uri.https('www.omdbapi.com', '/',
            {'apikey': 'f928eca6', 's': query, 'page': '1'}));
        if (data.statusCode != 200) {
          return [];
        }
      } else {
        return [];
      }
      jsonMovies = jsonDecode(data.body);
      if (jsonMovies['Response'] == 'False') {
        return [];
      }

      List<Movie> movies = [];

      for (dynamic movie in jsonMovies['Search']) {
        print(Movie.fromMap(movie));
        movies.add(Movie.fromMap(movie));
      }

      return movies;
    } catch (e) {
      print(e);
      // If encountering an error, return [].
      throw e;
    }
  }

  Future<Movie> getMovie(String id) async {
    try {
      var movieData = await http.get(
          Uri.https('www.omdbapi.com', '/', {'i': id, 'apikey': 'f928eca6'}));
      dynamic jsonMovies_2 = jsonDecode(movieData.body);
      return new Movie.fromMap(jsonMovies_2);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addMovie(Movie movie) async {
    MoviesRead.movies.add(movie);
  }
}

abstract class MovieService {
  Future<List<Movie>> getMovies(String query);
  Future<Movie> getMovie(String id);
}

class MovieSQLDecorator implements MovieService {
  final DBProvider db = DBProvider.db;
  MoviesRead service;
  MovieSQLDecorator(this.service);
  @override
  Future<List<Movie>> getMovies(String query) async {
    try {
      final movies = await service.getMovies(query);
      await db.newMovies(movies);
      return movies;
    } catch (SocketException) {
      print('ere');
      return db.getMovies(query);
    }
  }

  @override
  Future<Movie> getMovie(String id) async {
    try {
      print('adding movie');
      final movie = await service.getMovie(id);
      await db.newMovie(movie);
      return movie;
    } catch (SocketException) {
      print('catched');
      return db.getMovie(id);
    }
  }
}
