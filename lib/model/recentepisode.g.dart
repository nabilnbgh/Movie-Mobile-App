// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentepisode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentEpisode _$RecentEpisodeFromJson(Map<String, dynamic> json) =>
    RecentEpisode(
      episodeId: json['episodeId'] as String,
      animeTitle: json['animeTitle'] as String,
      episodeNum: json['episodeNum'] as String,
      subOrDub: json['subOrDub'] as String,
      animeImg: json['animeImg'] as String,
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
