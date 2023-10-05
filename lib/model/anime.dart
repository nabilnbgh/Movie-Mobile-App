import 'package:movie_application/model/metadataanime.dart';

class Anime extends MetadataAnime {
  Anime(String animeImg, String animeTitle,
      {required this.animeId, required this.animeUrl})
      : super(animeImg: animeImg, animeTitle: animeTitle);
  String animeId;
  String animeUrl;

  static fromJson(Map<String, dynamic> map) {
    return Anime(
      map['animeImg'],
      map['animeTitle'],
      animeId: map['animeId'],
      animeUrl: map['animeUrl'],
    );
  }
}
