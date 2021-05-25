class Photo {
  final String stringURL;
  Photo(this.stringURL);
  Photo.fromJson(Map<String, dynamic> json)
      : this.stringURL = json['largeImageURL'];
}
