// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      id: json['id'] as int?,
      results:
          (json['results'] as List<dynamic>?)?.map((e) => VideoResults.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) => <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };

VideoResults _$VideoResultsFromJson(Map<String, dynamic> json) => VideoResults(
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
      official: json['official'] as bool?,
      publishedAt: json['published_at'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$VideoResultsToJson(VideoResults instance) => <String, dynamic>{
      'iso6391': instance.iso6391,
      'iso31661': instance.iso31661,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'publishedAt': instance.publishedAt,
      'id': instance.id,
    };
