import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/moviecubit_cubit.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:flutter_application/view/MovieInfoPage.dart';
import 'package:flutter_application/widget/Search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddMoviePage.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final MoviecubitCubit myCubit = MoviecubitCubit(MovieService());
  String query = "";
  List<Movie> filteredMovies;
  List<Movie> allMovies;

  var id = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.add),
      //         onPressed: () {
      //           navigateSecondPage(MovieService());
      //         })
      //   ],
      //   title: Text("Movies"),
      // ),
      body: Column(children: [
        buildSearch(),
        BlocProvider(
          create: (context) => myCubit,
          child: BlocBuilder(
            cubit: myCubit,
            builder: (BuildContext context, state) {
              if (state is MoviecubitInitial) {
                myCubit.load(query);
              }
              if (state is MoviecubitLoading) {
                final spinkit = SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                );
                return Center(heightFactor: 3, child: spinkit);
              }
              if (state is MoviecubitLoaded) {
                allMovies = state.movies;

                return buildLoaded(allMovies, context);
              }
              return Container();
            },
          ),
        ),
      ]),
    );
  }

  Widget buildLoaded(List<Movie> movies, BuildContext context) {
    return Expanded(
      child: movies.length == 0 || query.length < 3
          ? Center(child: Text("No Results"))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Dismissible(
                  key: Key(movie.title),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      movies.removeAt(index);
                    });
                  },
                  child: ListTile(
                    onTap: () {
                      movies[index].imdbID == 'noid'
                          ? print('no')
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MovieInfoPage(movies[index].imdbID)),
                            );
                    },
                    subtitle: Container(
                      margin: EdgeInsets.only(bottom: 19),
                      height: 81,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                              height: 81,
                              width: 62,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: movies[index].poster == 'N/A'
                                        ? AssetImage(
                                            'assets/Posters/no_image.jpg')
                                        : NetworkImage(movies[index].poster)),
                              )),
                          SizedBox(
                            width: 21,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  movies[index].title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.openSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${movies[index].type}',
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${movies[index].year}',
                                  style: GoogleFonts.openSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title',
        onChanged: searchMovie,
      );

  void searchMovie(String query) async {
    myCubit.load(query);
    setState(() {
      this.query = query;
    });
  }

  Future reload(dynamic value) {
    id++;
    setState(() {});
  }
}
