import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int cycle = 0;
  List<Widget> _tiles = <Widget>[];
  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.amberAccent,
          child: Icon(Icons.add_photo_alternate_rounded),
          onPressed: () async {
            File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
  );

          if (image != null) {
            setState(() {
              _tiles.add(
                _Example01Tile(image),
              );
              cycle == 0 || cycle == 7
                  ? _staggeredTiles.add(StaggeredTile.count(2, 2))
                  :  _staggeredTiles.add(StaggeredTile.count(1, 1));
              cycle == 8 ? cycle = 0 : cycle += 1;
              print(cycle);
            });
          }
          }
        ),
        body: Container(
          child: _tiles.isEmpty
              ? Center(
                  child: Icon(
                    Icons.photo_camera_back,
                  ),
                )
              : StaggeredGridView.count(
                  crossAxisCount: 3,
                  staggeredTiles: _staggeredTiles,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: _tiles,
                ),
        ),
      ),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.image);

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