import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  Episode(
      {required this.episodeId,
      required this.episodeNum,
      required this.episodeUrl,
      required this.isSubbed,
      required this.isDubbed});
  String episodeId;
  String episodeNum;
  String episodeUrl;
  bool isSubbed;
  bool isDubbed;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
