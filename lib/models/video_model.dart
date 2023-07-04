import 'package:json_annotation/json_annotation.dart';
part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  int? id;
  List<VideoResults>? results;

  VideoModel({this.id, this.results});

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}

@JsonSerializable()
class VideoResults {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  VideoResults(
      {this.iso6391,
      this.iso31661,
      this.name,
      this.key,
      this.site,
      this.size,
      this.type,
      this.official,
      this.publishedAt,
      this.id});

  factory VideoResults.fromJson(Map<String, dynamic> json) => _$VideoResultsFromJson(json);
  Map<String, dynamic> toJson() => _$VideoResultsToJson(this);
}
