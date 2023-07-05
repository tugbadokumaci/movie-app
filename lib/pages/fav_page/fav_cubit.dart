import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie_result_model.dart';
import '../../utils/resource.dart';
import 'fav_repository.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavRepository _repo;

  FavCubit({required FavRepository repo})
      : _repo = repo,
        super(FavInitial());

  Resource<MovieResultModel> resource1 = Resource(status: Status.LOADING, data: null, errorMessage: null);
  Image? image;
  Future<void> getFavorites() async {
    resource1 = await _repo.getFavorites();
    final result = await _repo.getImage();

    if (resource1.status == Status.SUCCESS && result.status == Status.SUCCESS) {
      image = result.data;
      emit(FavSuccess());
    } else if (resource1.status == Status.ERROR) {
      debugPrint('fav cubit -> getFavorites -> resource 1 status ERROR');
    }
  }

  Future<void> refreash() async {
    emit(FavInitial());
  }
}
