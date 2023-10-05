import 'package:json_annotation/json_annotation.dart';
import 'package:movie_application/model/metadataanime.dart';

part 'recentepisode.g.dart';

@JsonSerializable()
class RecentEpisode extends MetadataAnime {
  RecentEpisode(
    String animeTitle,
    String animeImg, {
    required this.episodeId,
    required this.episodeNum,
    required this.subOrDub,
    required this.episodeUrl,
  }) : super(animeImg: animeImg, animeTitle: animeTitle);

  String episodeId;
  String episodeNum;
  String subOrDub;
  String episodeUrl;

  factory RecentEpisode.fromJson(Map<String, dynamic> json) =>
      _$RecentEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$RecentEpisodeToJson(this);
}
