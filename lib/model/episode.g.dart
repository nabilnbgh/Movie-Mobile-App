// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      episodeId: json['episodeId'] as String,
      episodeNum: json['episodeNum'] as String,
      episodeUrl: json['episodeUrl'] as String,
      isSubbed: json['isSubbed'] as bool,
      isDubbed: json['isDubbed'] as bool,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'episodeId': instance.episodeId,
      'episodeNum': instance.episodeNum,
      'episodeUrl': instance.episodeUrl,
      'isSubbed': instance.isSubbed,
      'isDubbed': instance.isDubbed,
    };
