import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/rick_and_morty/models.dart';
import '../models/rick_and_morty/responses.dart';

part 'rick_and_morty_rest_api.g.dart';

const baseRickAndMortyApiUrl = "https://rickandmortyapi.com/api/";

@RestApi(baseUrl: baseRickAndMortyApiUrl)
abstract class RickAndMortyRestApi {
  factory RickAndMortyRestApi(Dio dio, {String baseUrl}) = _RickAndMortyRestApi;

  @GET("/character")
  Future<CharacterPaginatedResponse> getCharacters([@Query("page") int? page]);

  @GET("/character/{id}")
  Future<Character> getCharacterById(@Path("id") int id);
  // @GET("/location")
  // Future<List<Task>> getTasks();
  // @GET("/episode")
  // Future<List<Task>> getTasks();
}
