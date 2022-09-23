import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_playground/api/rick_and_morty_rest_api.dart';

@lazySingleton
class RickAndMortyService {
  final RickAndMortyRestApi restApi;

  RickAndMortyService() : restApi = RickAndMortyRestApi(Dio());
}
