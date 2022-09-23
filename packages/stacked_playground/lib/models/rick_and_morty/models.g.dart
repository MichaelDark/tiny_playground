// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterLocation _$CharacterLocationFromJson(Map<String, dynamic> json) =>
    CharacterLocation(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$CharacterLocationToJson(CharacterLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['id'] as int,
      json['name'] as String,
      json['url'] as String,
      json['created'] as String,
      $enumDecode(_$CharacterStatusEnumMap, json['status'],
          unknownValue: CharacterStatus.unknown),
      json['species'] as String,
      json['type'] as String,
      $enumDecode(_$CharacterGenderEnumMap, json['gender'],
          unknownValue: CharacterGender.unknown),
      CharacterLocation.fromJson(json['origin'] as Map<String, dynamic>),
      CharacterLocation.fromJson(json['location'] as Map<String, dynamic>),
      json['image'] as String,
      (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'created': instance.created,
      'status': _$CharacterStatusEnumMap[instance.status]!,
      'species': instance.species,
      'type': instance.type,
      'gender': _$CharacterGenderEnumMap[instance.gender]!,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
    };

const _$CharacterStatusEnumMap = {
  CharacterStatus.dead: 'Dead',
  CharacterStatus.alive: 'Alive',
  CharacterStatus.unknown: 'unknown',
};

const _$CharacterGenderEnumMap = {
  CharacterGender.female: 'Female',
  CharacterGender.male: 'Male',
  CharacterGender.genderless: 'Genderless',
  CharacterGender.unknown: 'unknown',
};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      json['id'] as int,
      json['name'] as String,
      json['url'] as String,
      json['created'] as String,
      json['type'] as String,
      json['dimension'] as String,
      (json['residents'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'created': instance.created,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['id'] as int,
      json['name'] as String,
      json['url'] as String,
      json['created'] as String,
      json['air_date'] as String,
      json['episode'] as String,
      (json['character'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'created': instance.created,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'character': instance.character,
    };
