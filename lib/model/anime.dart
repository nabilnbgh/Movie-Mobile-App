class Anime {
  Anime(
      {required this.animeId,
      required this.animeTitle,
      required this.animeImg,
      required this.animeUrl});
  String animeId;
  String animeTitle;
  String animeImg;
  String animeUrl;

  static fromJson(Map<String, dynamic> map) {
    return Anime(
      animeId: map['animeId'],
      animeTitle: map['animeTitle'],
      animeImg: map['animeImg'],
      animeUrl: map['animeUrl'],
    );
  }
}
