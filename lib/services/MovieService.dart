import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:http/http.dart' as http;

class MovieService{
  static List<Movie> movies = [];
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
      }
      jsonMovies = jsonDecode(data.body);
      if (jsonMovies['Response'] == 'False') {
        return [];
      }
      print(jsonMovies);
      List<Movie> movies = [];
      for (dynamic movie in jsonMovies['Search']) {
        movies.add(Movie.fromJson(movie));
      }

      return movies;
    } catch (e) {
      print(e);
      // If encountering an error, return [].
      return [];
    }
  }

  Future<Movie> getMovie(String id) async {
    try {
      print(id);
      var movieData = await http.get(
          Uri.https('www.omdbapi.com', '/', {'i': id, 'apikey': 'f928eca6'}));
      dynamic jsonMovies_2 = jsonDecode(movieData.body);
      return new Movie.fromJson(jsonMovies_2);
    } catch (e) {}
    return null;
  }

  Future<void> addMovie(Movie movie) async {
    MovieService.movies.add(movie);
    print(MovieService.movies.length);
  }
}