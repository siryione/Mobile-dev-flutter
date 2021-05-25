import 'dart:convert';

import 'package:flutter_application/model/Photo.dart';
import 'package:http/http.dart' as http;

class PhotoService {
  Future<List<Photo>> getPhotos() async {
    try {
      var data = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=yellow+flowers&image_type=photo&per_page=27'));
      if (data.statusCode != 200) {
        return [];
      }

      dynamic jsonPhotos = jsonDecode(data.body);
      print(jsonPhotos);
      if (jsonPhotos['Response'] == 'False') {
        return [];
      }
      List<Photo> photoes = [];
      for (dynamic photo in jsonPhotos['hits']) {
        photoes.add(Photo.fromJson(photo));
      }

      return photoes;
    } catch (e) {
      print(e);
      // If encountering an error, return [].
      return [];
    }
  }
}