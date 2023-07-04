import 'package:movie_app/generator.dart';
import 'package:movie_app/models/movie_result_model.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/resource.dart';

mixin MixinMovieFeature {
  RestClient client = locator<RestClient>();

  Future<Resource<MovieResultModel>> getTrendingMovie() async {
    try {
      final result = await client.getTrendingMovie(ApiConstants.API_KEY);
      return Resource.success(result);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<Results>> getMovieDetail(int movieId) async {
    try {
      final result = await client.getMovieDetail(ApiConstants.API_KEY, movieId);
      return Resource.success(result);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }
}
