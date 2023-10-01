import 'package:json_annotation/json_annotation.dart';

part 'vidcdn.g.dart';

@JsonSerializable()
class VidCDN {
  VidCDN(
      {required this.referer, required this.sources, required this.sources_bk});
  String referer;
  List<Data> sources;
  List<Data> sources_bk;
  factory VidCDN.fromJson(Map<String, dynamic> json) => _$VidCDNFromJson(json);
  Map<String, dynamic> toJson() => _$VidCDNToJson(this);
}

@JsonSerializable()
class Data {
  Data({required this.file, required this.label, required this.type});
  String file;
  String label;
  String type;
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
