import 'package:movie_app/inheritance/mixin_movie_feature.dart';
import 'package:movie_app/models/movie_result_model.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/resource.dart';
import '../../generator.dart';
import '../../models/genre_model.dart';

const apiKey = ApiConstants.API_KEY;

class HomeRepository with MixinMovieFeature {
  RestClient client;

  HomeRepository(this.client);

  Future<Resource<MovieResultModel>> getNowPlayingMovie() async {
    try {
      return Resource.success(await client.getNowPlayingMovie(apiKey));
    } catch (e) {
      return Resource.error('Failed to fetch now playing movies: $e');
    }
  }

  // Future<Resource<MovieResultModel>> getTrendingMovie() async {
  //   try {
  //     return Resource.success(await client.getTrendingMovie(apiKey));
  //   } catch (e) {
  //     throw Resource.error('Failed to fetch trending movies: $e');
  //   }
  // }

  Future<Resource<MovieResultModel>> getWithGenres(String genre) async {
    try {
      return Resource.success(await client.getWithGenres(apiKey, genre));
    } catch (e) {
      throw Resource.error('Failed to fetch movies with genres: $e');
    }
  }

  Future<Resource<GenreModel>> getGenreList() async {
    try {
      return Resource.success(await client.getGenreList(apiKey));
    } catch (e) {
      throw Resource.error('Failed to fetch movies with genres: $e');
    }
  }
}
