import 'package:json_annotation/json_annotation.dart';

part 'recentepisode.g.dart';

@JsonSerializable()
class RecentEpisode {
  RecentEpisode({
    required this.episodeId,
    required this.animeTitle,
    required this.episodeNum,
    required this.subOrDub,
    required this.animeImg,
    required this.episodeUrl,
  });

  String episodeId;
  String animeTitle;
  String episodeNum;
  String subOrDub;
  String animeImg;
  String episodeUrl;

  factory RecentEpisode.fromJson(Map<String, dynamic> json) =>
      _$RecentEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$RecentEpisodeToJson(this);
}
