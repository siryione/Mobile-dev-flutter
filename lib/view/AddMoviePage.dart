import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/model/Movie.dart';
import 'package:flutter_application/services/MovieService.dart';

class AddMoviePage extends StatelessWidget {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController yearEditingController = TextEditingController();
  final TextEditingController typeEditingController = TextEditingController();
  final MovieService service;
  AddMoviePage(this.service);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Programming assignment'),
            ),
      body: Container(
        padding: EdgeInsets.only(top:25, right: 25, left:25),
        child: Column(
        children: <Widget>[
          TextField(
                controller: titleEditingController,
                decoration: new InputDecoration(labelText: "Title"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
              TextField(
                controller: yearEditingController,
                decoration: new InputDecoration(labelText: "Year"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              TextField(
                controller: typeEditingController,
                decoration: new InputDecoration(labelText: "Type"),
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
              OutlineButton(onPressed: (){
                titleEditingController.text.isEmpty || yearEditingController.text.isEmpty || typeEditingController.text.isEmpty ? AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ) :   
                this.service.addMovie(Movie(poster : '', title: titleEditingController.text, year: yearEditingController.text, type: typeEditingController.text));
                Navigator.of(context).pop();
              }, child: Text('Add movie'))
        ]
      ),
    )
    );
  }
}