import 'package:movie_application/model/episode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animedetail.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimeDetail {
  AnimeDetail(
      {required this.animeTitle,
      required this.type,
      required this.releasedDate,
      required this.status,
      required this.genres,
      required this.otherNames,
      required this.synopsis,
      required this.animeImg,
      required this.totalEpisodes,
      required this.episodesList});

  String animeTitle;
  String type;
  String releasedDate;
  String status;
  List<String> genres;
  String otherNames;
  String synopsis;
  String animeImg;
  String totalEpisodes;
  List<Episode> episodesList;

  factory AnimeDetail.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeDetailToJson(this);

}
