import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/classes/Movie.dart';

class AddMovie extends StatelessWidget {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController typeEditingController = TextEditingController();
  final TextEditingController yearEditingController = TextEditingController();
  final MoviesRead service;
  AddMovie(this.service);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Movie"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            children: [
              new TextField(
                controller: titleEditingController,
                decoration: new InputDecoration(labelText: "Title"),
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
              new TextField(
                controller: yearEditingController,
                decoration: new InputDecoration(labelText: "Year"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              new TextField(
                controller: typeEditingController,
                decoration: new InputDecoration(labelText: "Type"),
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
              OutlineButton(
                  highlightedBorderColor: Colors.green,
                  color: Colors.greenAccent,
                  child: Text("Add Movie to List"),
                  onPressed: () {
                    this.service.addMovie(Movie(
                          poster: "",
                          title: titleEditingController.text,
                          year: yearEditingController.text,
                          type: typeEditingController.text,
                        ));
                    Navigator.of(context).pop();
                  })
            ],
          )),
        ),
      ),
    );
  }
}
