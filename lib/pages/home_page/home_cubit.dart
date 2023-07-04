import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/pages/home_page/home_repository.dart';

import '../../models/movie_result_model.dart';
import '../../utils/resource.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repo;
  Resource<MovieResultModel> resource1 = Resource(status: Status.LOADING, data: null, errorMessage: null);
  Resource<MovieResultModel> resource2 = Resource(status: Status.LOADING, data: null, errorMessage: null);
  Resource<GenreModel> resource3 = Resource(status: Status.LOADING, data: null, errorMessage: null);
  Resource<MovieResultModel> resource4 = Resource(status: Status.LOADING, data: null, errorMessage: null);
  Genres selectedGenre = Genres(id: 28, name: 'Action');

  HomeCubit({
    required HomeRepository repo,
  })  : _repo = repo,
        super(HomeInitial());

  Future<void> getNowPlayingMovie() async {
    resource1 = await _repo.getNowPlayingMovie();
    if (resource1.status == Status.SUCCESS) {
      emit(HomeSuccess());
    } else if (resource1.status == Status.ERROR) {
      debugPrint('home cubit -> getNowPlayingMovie -> resource 1 status ERROR');
    }
  }

  Future<void> getTrendingMovie() async {
    resource2 = await _repo.getTrendingMovie();
    if (resource2.status == Status.SUCCESS) {
      emit(HomeSuccess());
    } else if (resource2.status == Status.ERROR) {
      debugPrint('home cubit -> getTrendingMovie -> resource 2 status ERROR');
    }
  }

  Future<void> getGenreList() async {
    resource3 = await _repo.getGenreList();
    if (resource3.status == Status.SUCCESS) {
      emit(HomeSuccess());
    } else if (resource3.status == Status.ERROR) {
      debugPrint('home cubit -> getGenreList -> resource 3 status ERROR');
    }
  }

  Future<void> getWithGenres(Genres genre) async {
    selectedGenre.name = genre.name;
    resource4 = await _repo.getWithGenres(genre.id.toString());
    if (resource4.status == Status.SUCCESS) {
      emit(HomeSuccess());
    } else if (resource4.status == Status.ERROR) {
      debugPrint('home cubit -> getWithGenres -> resource 4 status ERROR');
    }
  }
}
