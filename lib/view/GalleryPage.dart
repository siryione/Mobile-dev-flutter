import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/classes/Photo.dart';
import 'package:flutter_application/cubit/photos_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final PhotosCubit photoCubit = PhotosCubit(PhotoSQLDecorator(PhotoesRead()));
  int cycle = 0;
  List<String> photoes = [];

  List<Widget> _tiles = <Widget>[];

  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => photoCubit,
      child: BlocBuilder(
          cubit: photoCubit,
          builder: (BuildContext context, state) {
            if (state is PhotosInitial) {
              photoCubit.load();
              final spinkit = SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              );
              return Center(child: spinkit);
            }
            if (state is PhotosLoading) {
              final spinkit = SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              );
              return Center(child: spinkit);
            }
            if (state is PhotosLoaded) {
              photoes = state.photoes;
              print('here' + photoes.length.toString());
              return buildLoaded(photoes);
            }
            return Container();
          }),
    );
  }
}

Widget buildLoaded(List<String> photoes) {
  List<StaggeredTile> _preLoadStaggeredTiles = <StaggeredTile>[];
  List<Widget> _preLoadTiles = [];
  int incycle = 0;
  for (String photo in photoes) {
    _preLoadTiles.add(_URLImageTile(photo));
    incycle == 0 || incycle == 7
        ? _preLoadStaggeredTiles.add(StaggeredTile.count(2, 2))
        : _preLoadStaggeredTiles.add(StaggeredTile.count(1, 1));
    incycle == 8 ? incycle = 0 : incycle += 1;
  }
  print(_preLoadTiles.length);
  return Scaffold(
    body: Container(
      child: StaggeredGridView.count(
        crossAxisCount: 3,
        staggeredTiles: _preLoadStaggeredTiles,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: _preLoadTiles,
      ),
    ),
  );
}

class _preLoadstaggeredTiles {}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.image);

  final File image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {},
          child: Image.file(
            image,
            fit: BoxFit.cover,
          )),
    );
  }
}

class _URLImageTile extends StatelessWidget {
  const _URLImageTile(this.image);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Image.network(
          image,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
