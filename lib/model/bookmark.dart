import 'package:json_annotation/json_annotation.dart';
import 'package:movie_application/model/metadataanime.dart';
part 'bookmark.g.dart';

@JsonSerializable(createToJson: false)
class Bookmark extends MetadataAnime {
  Bookmark(
    String animeTitle,
    String animeImg, {
    required this.animeId,
  }) : super(animeImg: animeImg, animeTitle: animeTitle);
  String animeId;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}
