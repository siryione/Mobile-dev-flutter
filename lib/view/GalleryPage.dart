import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/cubit/cubitphoto_cubit.dart';
import 'package:flutter_application/model/Photo.dart';
import 'package:flutter_application/services/PhotoService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Photo> photos = [];
  int cycle = 0;
  final CubitphotoCubit myCubit = CubitphotoCubit(PhotoService());
  List<Widget> _tiles = <Widget>[];
  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

   @override
  Widget build(BuildContext context) {
        return BlocProvider(
      create: (context) => myCubit,
      child: BlocBuilder(
        cubit: myCubit,
        builder: (BuildContext context, state) {
          if (state is CubitphotoInitial) {
            myCubit.load();
          }
          if (state is CubitphotoLoading) {
            return Text("Loading ...");
          }
          if (state is CubitphotoLoaded) {
            photos = state.photos;
            return buildLoaded(photos);
          }
          return Container();
        },
          ),
    );
}

Widget buildLoaded(List<Photo> photos) {
  List<StaggeredTile> _preLoadStaggeredTiles = <StaggeredTile>[];
  List<Widget> _preLoadTiles = [];
  int incycle = 0;
  for (Photo photo in photos) {
    _preLoadTiles.add(_URLImageTile(photo.stringURL));
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