import 'package:movie_app/inheritance/mixin_movie_feature.dart';

import '../../generator.dart';
import '../../models/movie_result_model.dart';
import '../../utils/constants.dart';
import '../../utils/resource.dart';

const apiKey = ApiConstants.API_KEY;

class SearchRepository with MixinMovieFeature {
  RestClient client;

  SearchRepository(this.client);

  Future<Resource<MovieResultModel>> searchMovies(String query) async {
    try {
      final result = await client.searchMovies(apiKey, query);
      return Resource.success(result);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  // Future<Resource<MovieResultModel>> getTrendingMovie() async {
  //   try {
  //     return Resource.success(await client.getTrendingMovie(apiKey));
  //   } catch (e) {
  //     throw Resource.error('Failed to fetch trending movies: $e');
  //   }
  // }
}
