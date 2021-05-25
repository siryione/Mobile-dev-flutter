import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/moviecubit_cubit.dart';
import 'package:flutter_application/cubitInfo/movieinfo_cubit.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieInfoPage extends StatelessWidget {
  final String id;
  MovieInfoPage(this.id);
  final MovieinfoCubit infoCubit = MovieinfoCubit(MovieService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => infoCubit,
      child: BlocBuilder(
        cubit: infoCubit,
        builder: (BuildContext context, state) {
          if (state is MovieinfoInitial) {
            print('object');
            infoCubit.load(id);
          }
          if (state is MovieinfoLoading) {
            return Text("Loading ...");
          }
          if (state is MovieinfoLoaded) {
            return buildLoaded(state.movie, context);
          }
          return Container();
        },
      ),
    );
  }
  Widget buildLoaded(Movie movie, BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                movie.poster == "" ? 'assets/Posters/no_image.jpg' : 'assets/Posters/' + movie.poster,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                movie.title + " (" + movie.year + ")",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                            Text("Released: " + movie.released),
                        Text("Rated: " + movie.rated),
                        Text("Runtime: " + movie.runtime),
                        Text("Language: " + movie.language),
                        Text("Country: " + movie.country),
                        Text("Genre: " + movie.genre),
                        Text("Director: " + movie.director),
                    Text("Writer: " + movie.writer),
                    Text("Production: " + movie.production),
                    Text("Actors: " + movie.actors),
                    Text("Awards: " + movie.awards),
                    Text("Plot: " + movie.plot),
                    Text(movie.imdbRating + "/10"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}