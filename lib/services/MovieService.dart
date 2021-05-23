import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application/model/Movie.dart';

class MovieService{
  static List<Movie> movies = [];
  Future<List<Movie>> getMovies(String query) async {
    try {
      String data = await rootBundle.loadString('assets/MoviesList.txt');
      dynamic jsonMovies = jsonDecode(data);
      List<Movie> moviesLocal = [];
      for (dynamic movie in jsonMovies['Search']) {
        moviesLocal.add(Movie.fromJson(movie));
      }

      List<Movie> moviesFiltered = [];
      if (query.isNotEmpty) {
        for (Movie movie in moviesLocal) {
          if (movie.title.toLowerCase().contains(query.toLowerCase())) {
            moviesFiltered.add(movie);
          }
        }
        moviesLocal = moviesFiltered;
      }
      // if (MovieService.movies.isEmpty) {
      //   MovieService.movies = movies;
      // }
      moviesLocal.addAll(MovieService.movies);
      print('object'+moviesLocal.length.toString());
      return moviesLocal;
    } catch (e) {
      // If encountering an error, return [].
      return [];
    }
  }

  Future<Movie> getMovie(String id) async {
    try {
      print(id);
      String movieData = await rootBundle.loadString('assets/' + id + '.txt');
      dynamic jsonMovies_2 = jsonDecode(movieData);
      return new Movie.fromJson(jsonMovies_2);
    } catch (e) {}
    return null;
  }

  Future<void> addMovie(Movie movie) async {
    MovieService.movies.add(movie);
    print(MovieService.movies.length);
  }
}