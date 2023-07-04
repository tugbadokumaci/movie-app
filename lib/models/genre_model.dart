import 'package:json_annotation/json_annotation.dart';
part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel {
  List<Genres>? genres;

  GenreModel({this.genres});
  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
  Map<String, dynamic> toJson() => _$GenresToJson(this);
}
