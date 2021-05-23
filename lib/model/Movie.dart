import 'package:flutter/material.dart';

class Movie{
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
  Movie.fromJson(Map<String, dynamic> json)
      : title = json['Title'],
        year = json['Year'],
        poster = json['Poster'],
        rated = json['Rated'],
        released = json['Released'],
        runtime = json['Runtime'],
        genre = json['Genre'],
        director = json['Director'],
        writer = json['Writer'],
        actors = json['Actors'],
        plot = json['Plot'],
        language = json['Language'],
        country = json['Country'],
        awards = json['Awards'],
        imdbRating = json['imdbRating'],
        imdbVotes = json['imdbVotes'],
        imdbID = json['imdbID'],
        type = json['Type'],
        production = json['Production'];
  Map<String, dynamic> toJson(Map<String, dynamic> json) =>
      {json['Title']: title, json['Year']: year, json['Type']: type};
}