import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/classes/DataBase.dart';
import 'package:http/http.dart' as http;

class Photo {
  final String largeImageURL;
  const Photo({this.largeImageURL});

  String toString() {
    return 'Photo: {$largeImageURL}';
  }

  Map<String, dynamic> toMap() {
    return {'stringURL': largeImageURL};
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Photo(largeImageURL: map['largeImageURL']);
  }
  String toJson() => json.encode(toMap());
  factory Photo.fromJson(String source) => Photo.fromMap(json.decode(source));
}

class PhotoesRead implements PhotoService {
  @override
  Future<List<String>> getPhotoes() async {
    try {
      var data = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=yellow+flowers&image_type=photo&per_page=27'));
      print(data.statusCode);
      if (data.statusCode != 200) {
        return [];
      }

      dynamic jsonPhotoes = jsonDecode(data.body);
      if (jsonPhotoes['Response'] == 'False') {
        return [];
      }

      List<String> photoes = [];
      for (dynamic photo in jsonPhotoes['hits']) {
        photoes.add(photo['largeImageURL']);
      }
      print(photoes);
      return photoes;
    } catch (e) {
      print(e);

      // If encountering an error, return [].
      return [];
    }
  }
}

abstract class PhotoService {
  Future<List<String>> getPhotoes();
}

class PhotoSQLDecorator implements PhotoService {
  final DBProvider db = DBProvider.db;
  PhotoesRead service;
  PhotoSQLDecorator(this.service);
  @override
  Future<List<String>> getPhotoes() async {
    try {
      final check = await db.getPhotoes();
      print(check.length.toString() + 'check');
      if (check.length != 0) {
        return check;
      } else {
        print('else');
        final res = await service.getPhotoes();
        print('her2' + res.length.toString());
        await db.newPhotoes(res);
        return res;
      }
    } on NetworkImageLoadException {
      print('hello');
      return [];
    } on Exception {
      print('expeption');
    }
  }
}
