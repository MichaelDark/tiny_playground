// Models are from
// https://github.com/afuh/rick-and-morty-api-node
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

class BaseModel {
  final int id;
  final String name;
  final String url;
  final String created;

  const BaseModel(this.id, this.name, this.url, this.created);
}

@JsonSerializable()
class CharacterLocation {
  final String name;
  final String url;

  const CharacterLocation(this.name, this.url);

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);
}

enum CharacterStatus {
  @JsonValue('Dead')
  dead,
  @JsonValue('Alive')
  alive,
  @JsonValue('unknown')
  unknown,
}

enum CharacterGender {
  @JsonValue('Female')
  female,
  @JsonValue('Male')
  male,
  @JsonValue('Genderless')
  genderless,
  @JsonValue('unknown')
  unknown,
}

@JsonSerializable()
class Character extends BaseModel {
  @JsonKey(unknownEnumValue: CharacterStatus.unknown)
  final CharacterStatus status;
  final String species;
  final String type;
  @JsonKey(unknownEnumValue: CharacterGender.unknown)
  final CharacterGender gender;
  final CharacterLocation origin;
  final CharacterLocation location;
  final String image;
  final List<String> episode;

  const Character(
    super.id,
    super.name,
    super.url,
    super.created,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
  );

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class Location extends BaseModel {
  final String type;
  final String dimension;
  final List<Character> residents;

  const Location(
    super.id,
    super.name,
    super.url,
    super.created,
    this.type,
    this.dimension,
    this.residents,
  );

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Episode extends BaseModel {
  @JsonKey(name: "air_date")
  final String airDate;
  final String episode;
  final List<String> character;

  const Episode(
    super.id,
    super.name,
    super.url,
    super.created,
    this.airDate,
    this.episode,
    this.character,
  );

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

// class ApiResponse<T> {
//   /** The HTTP status code from the API response */
//   final status: number
//   /** The HTTP status message from the API response */
//   final statusMessage: string
//   /** The response that was provided by the API */
//   final data: T
// }
