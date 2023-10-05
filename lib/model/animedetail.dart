import 'package:movie_application/model/episode.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_application/model/metadataanime.dart';

part 'animedetail.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimeDetail extends MetadataAnime {
  AnimeDetail(String animeTitle, String animeImg,
      {required this.type,
      required this.releasedDate,
      required this.status,
      required this.genres,
      required this.otherNames,
      required this.synopsis,
      required this.totalEpisodes,
      required this.episodesList})
      : super(animeImg: animeImg, animeTitle: animeTitle);

  String type;
  String releasedDate;
  String status;
  List<String> genres;
  String otherNames;
  String synopsis;
  String totalEpisodes;
  List<Episode> episodesList;

  factory AnimeDetail.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeDetailToJson(this);
}
