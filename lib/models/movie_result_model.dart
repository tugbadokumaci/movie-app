import 'package:json_annotation/json_annotation.dart';
part 'movie_result_model.g.dart';

@JsonSerializable()
class MovieResultModel {
  List<Results>? results;

  MovieResultModel({this.results});

  factory MovieResultModel.fromJson(Map<String, dynamic> json) => _$MovieResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResultModelToJson(this);
}

@JsonSerializable()
class Results {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Results(
      {this.adult,
      this.backdropPath,
      this.id,
      this.title,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.mediaType,
      this.genreIds,
      this.popularity,
      this.releaseDate,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
