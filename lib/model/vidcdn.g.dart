// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vidcdn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VidCDN _$VidCDNFromJson(Map<String, dynamic> json) => VidCDN(
      referer: json['referer'] as String,
      sources: (json['sources'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      sources_bk: (json['sources_bk'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );  

Map<String, dynamic> _$VidCDNToJson(VidCDN instance) => <String, dynamic>{
      'referer': instance.referer,
      'sources': instance.sources,
      'sources_bk': instance.sources_bk,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      file: json['file'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'file': instance.file,
      'label': instance.label,
      'type': instance.type,
    };
