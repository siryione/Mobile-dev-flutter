import 'package:flutter/material.dart';
import 'package:flutter_application/aboutmoviecubit/aboutmoviecubit_cubit.dart';
import 'package:flutter_application/classes/Movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieInfoPage extends StatelessWidget {
  final String id;
  MovieInfoPage(this.id);
  final AboutmoviecubitCubit aboutCubit =
      AboutmoviecubitCubit(MovieSQLDecorator(MoviesRead()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => aboutCubit,
      child: BlocBuilder(
        cubit: aboutCubit,
        builder: (BuildContext context, state) {
          if (state is AboutmoviecubitInitial) {
            aboutCubit.load(id);
            final spinkit = SpinKitRotatingCircle(
              color: Colors.blue,
              size: 50.0,
            );

            return Center(child: spinkit);
          }
          if (state is AboutmoviecubitLoading) {
            return Text("Loading");
          }
          if (state is AboutmoviecubitLoaded) {
            try {
              return buildLoaded(state.movie, context);
            } catch (Exception) {
              print(Exception);
              return Center(
                  child: Text(
                'Something went wrong :/',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ));
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget buildLoaded(Movie movie, BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title), backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              movie.poster == "" ||
                      movie.poster == null ||
                      movie.poster == 'N/A'
                  ? Image.asset('assets/Posters/no_image.jpg')
                  : Image.network(
                      movie.poster,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              Text(
                movie.title + " (" + movie.year + ")",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ColoredBox(
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("IMDb Rating",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(movie.imdbRating + "/10",
                                  style: TextStyle(fontSize: 30)),
                              Text(movie.imdbVotes + " votes")
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Writer: " + movie.writer),
                    Text("Production: " + movie.production),
                    Text("Actors: " + movie.actors),
                    Text("Awards: " + movie.awards),
                    Text("Plot: " + movie.plot)
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
