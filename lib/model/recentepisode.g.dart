// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentepisode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentEpisode _$RecentEpisodeFromJson(Map<String, dynamic> json) =>
    RecentEpisode(
      json['animeTitle'] as String,
      json['animeImg'] as String,
      episodeId: json['episodeId'] as String,
      episodeNum: json['episodeNum'] as String,
      subOrDub: json['subOrDub'] as String,
      episodeUrl: json['episodeUrl'] as String,
    );

Map<String, dynamic> _$RecentEpisodeToJson(RecentEpisode instance) =>
    <String, dynamic>{
      'episodeId': instance.episodeId,
      'animeTitle': instance.animeTitle,
      'episodeNum': instance.episodeNum,
      'subOrDub': instance.subOrDub,
      'animeImg': instance.animeImg,
      'episodeUrl': instance.episodeUrl,
    };
