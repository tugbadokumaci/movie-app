import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/search_page/search_repository.dart';
import 'package:movie_app/pages/search_page/search_state.dart';

import '../../models/movie_result_model.dart';
import '../../utils/resource.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repo;
  SearchCubit({
    required SearchRepository repo,
  })  : _repo = repo,
        super(SearchInitial());
  TextEditingController searchController = TextEditingController();

  Resource<MovieResultModel> resource1 = Resource(status: Status.LOADING, data: null, errorMessage: null); // Result
  Resource<MovieResultModel> resource2 = Resource(status: Status.LOADING, data: null, errorMessage: null); // Trending

  Future<void> searchMovies(String value) async {
    // emit(HomeLoading());
    resource1 = await _repo.searchMovies(value);
    if (resource1.status == Status.SUCCESS) {
      if (searchController.text == '') {
        emit(SearchInitial());
      } else {
        emit(SearchSuccess());
      }
    } else {
      debugPrint(resource1.errorMessage);
      debugPrint('search cubit -> searchMovies -> resource 1 status ERROR');
    }
  }

  Future<void> getTrendingMovie() async {
    resource2 = await _repo.getTrendingMovie();
    if (resource2.status == Status.SUCCESS) {
      emit(SearchInitial());
    } else if (resource2.status == Status.ERROR) {
      debugPrint('search cubit -> getTrendingMovie -> resource 2 status ERROR');
    }
  }
}
