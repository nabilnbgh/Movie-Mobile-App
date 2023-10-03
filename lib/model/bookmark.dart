import 'package:json_annotation/json_annotation.dart';
part 'bookmark.g.dart';

@JsonSerializable(createToJson: false)
class Bookmark {
  Bookmark({
    required this.animeId,
    required this.animeTitle,
    required this.animeImg,
  });
  String animeId;
  String animeTitle;
  String animeImg;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}
