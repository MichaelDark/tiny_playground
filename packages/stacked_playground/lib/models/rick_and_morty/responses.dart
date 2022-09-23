import 'package:json_annotation/json_annotation.dart';

import 'models.dart';
import 'paginated_response.dart';

part 'responses.g.dart';

@JsonSerializable()
class CharacterPaginatedResponse extends PaginatedResponse<Character> {
  CharacterPaginatedResponse({required super.info, required super.results});

  factory CharacterPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterPaginatedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterPaginatedResponseToJson(this);
}

@JsonSerializable()
class LocationPaginatedResponse extends PaginatedResponse<Location> {
  LocationPaginatedResponse({required super.info, required super.results});

  factory LocationPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationPaginatedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LocationPaginatedResponseToJson(this);
}

@JsonSerializable()
class EpisodePaginatedResponse extends PaginatedResponse<Episode> {
  EpisodePaginatedResponse({required super.info, required super.results});

  factory EpisodePaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodePaginatedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodePaginatedResponseToJson(this);
}
