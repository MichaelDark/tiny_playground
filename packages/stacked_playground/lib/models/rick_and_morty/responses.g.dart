// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterPaginatedResponse _$CharacterPaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    CharacterPaginatedResponse(
      info: PaginationInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterPaginatedResponseToJson(
        CharacterPaginatedResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

LocationPaginatedResponse _$LocationPaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    LocationPaginatedResponse(
      info: PaginationInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationPaginatedResponseToJson(
        LocationPaginatedResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

EpisodePaginatedResponse _$EpisodePaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    EpisodePaginatedResponse(
      info: PaginationInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodePaginatedResponseToJson(
        EpisodePaginatedResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };
