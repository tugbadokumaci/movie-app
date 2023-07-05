import 'package:movie_app/models/video_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/models/movie_result_model.dart';
import 'package:movie_app/utils/constants.dart';

import 'models/genre_model.dart';

part 'generator.g.dart';

@RestApi(baseUrl: ApiConstants.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/movie/now_playing')
  Future<MovieResultModel> getNowPlayingMovie(
    @Query('api_key') String apiKey,
  );

  @GET('/trending/movie/day')
  Future<MovieResultModel> getTrendingMovie(
    @Query('api_key') String apiKey,
  );

  @GET('/discover/movie')
  Future<MovieResultModel> getWithGenres(
    @Query('api_key') String apiKey,
    @Query('with_genres') String genre,
  );

  @GET('/genre/movie/list')
  Future<GenreModel> getGenreList(
    @Query('api_key') String apiKey,
  );

  @GET('/movie/{movieId}')
  Future<Results> getMovieDetail(
    @Query('api_key') String apiKey,
    @Path('movieId') int movieId,
  );

  @GET('/search/movie')
  Future<MovieResultModel> searchMovies(
    @Query('api_key') String apiKey,
    @Query('query') String query,
  );

  @GET('/movie/{movieId}/videos')
  Future<VideoModel> getYoutubeId(
    @Query('api_key') String apiKey,
    @Path('movieId') int movieId,
  );
}
