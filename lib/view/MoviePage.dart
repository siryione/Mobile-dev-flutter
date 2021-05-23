import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/moviecubit_cubit.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';
import 'package:flutter_application/widget/Search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final controller = TextEditingController();
  var id = 0;
  List moviesStart = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myCubit,
      child: BlocBuilder(
        cubit: myCubit,
        builder: (BuildContext context, state) {
          if (state is MoviecubitInitial) {
            myCubit.load(query);
          }
          if (state is MoviecubitLoading) {
            return Text("Loading ...");
          }
          if (state is MoviecubitLoaded) {
            moviesStart = state.movies;
            print(moviesStart.length);
            return buildLoaded(moviesStart, context, controller);
          }
          return Container();
        },
      ),
    );
  }
    Widget buildLoaded(List<Movie> movies, BuildContext context, controller) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoviePage(MovieService()))).then(reload);
              }, ),
              body: Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    buildSearch(),
                    Padding(
                      padding: EdgeInsets.only(left:25, top: 25),
                      child: Text(
                            'Discover latest films',
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(top:25, right: 25, left:25),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        // return Container(

                        return Dismissible(                          
                          // Each Dismissible must contain a Key. Keys allow Flutter to
                          // uniquely identify widgets.
                          key: Key(movies[index].title),
                          // Provide a function that tells the app
                          // what to do after an item has been swiped away.
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              movies.removeAt(index);
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 19),
                              height: 81,
                              width: MediaQuery.of(context).size.width -50,
                            child: Row(
                              
                              children: <Widget>[

                                Container(
                                  height: 81,
                                  width: 62,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: movies[index].poster == '' ? AssetImage('assets/Posters/no_image.jpg') : AssetImage('assets/Posters/' + movies[index].poster)
                                    ),
                                  )
                                ),
                                SizedBox(
                                  width: 21,
                                ),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(movies[index].title, 
                                    overflow: TextOverflow.fade, 
                                    maxLines: 1,
                                    softWrap: false,
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),),
                                    SizedBox(height: 5,),
                                    Text('${movies[index].type}', style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),),
                                    SizedBox(height: 5,),
                                    Text('${movies[index].year}', style: GoogleFonts.openSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),),
                                  ]
                                )
                                )
                              ],
                            ),
                          )
                        );
        
                          // return ListTile(
                          //   leading: movies[index].poster == '' ? Image.asset('assets/Posters/no_image.jpg') : Image.asset('assets/Posters/' + movies[index].poster),
                          //   title: Text('${movies[index].title}'),
                          //   );
                      }
                    ), 
                  ],
                ),
              ),
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
