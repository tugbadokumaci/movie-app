import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/movie_result_model.dart';
import '../../utils/resource.dart';
import 'detail_repository.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailRepository _repo;
  DetailCubit({
    required DetailRepository repo,
  })  : _repo = repo,
        super(DetailInitial());

  Resource<List<int>> resource1 = Resource(status: Status.LOADING, data: null, errorMessage: null); // isUpdateSuccess
  Resource<Results> resource2 = Resource(status: Status.LOADING, data: null, errorMessage: null); // movie data
  Resource<String> resource3 = Resource(status: Status.LOADING, data: null, errorMessage: null); // youtube id
  YoutubePlayerController? controller;

  Future<void> updateFavList(int movieId) async {
    // resource1 = await _repo.getFavList();
    if (resource1.status == Status.SUCCESS) {
      if (resource1.data!.contains(movieId)) {
        resource1.data!.remove(movieId);
      } else {
        resource1.data!.add(movieId);
      }
      _repo.setFavList(resource1.data!);
      emit(DetailSuccess(resource1.data!.contains(movieId)));
    }

    /// Constants.USER.favList.contains(viewModel.resource2.data!.id) ? Colors.red : Colors.white
  }

  Future<void> getMovieDetail(int movieId) async {
    resource1 = await _repo.getFavList();
    resource2 = await _repo.getMovieDetail(movieId);
    resource3 = await _repo.getYoutubeId(movieId);

    debugPrint('resource 2 created $resource2');
    if (resource2.status == Status.SUCCESS &&
        resource2.status == Status.SUCCESS &&
        resource3.status == Status.SUCCESS) {
      debugPrint('controller ın atanacağı video id ::::::${resource3.data}');
      controller = YoutubePlayerController(
        initialVideoId: resource3.data!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ),
      );
      debugPrint('after assinging controller ::::::${controller!.initialVideoId.toString()}');
      emit(DetailSuccess(resource1.data!.contains(movieId), isPlayerVisible: true)); // Now resource2 has movie details
    } else {
      debugPrint('detail cubit getmoviedetail resource1-2-3 error');
    }
  }

  //   Future<void> showVideo(int movieId) async {
  //   resource3 = await _repo.getYoutubeId(movieId);

  //   if (resource3.status == Status.SUCCESS) {
  //     controller?.dispose(); // Dispose the previous controller if it exists
  //     // debugPrint(resource3.data.toString());

  //     controller = YoutubePlayerController(
  //       initialVideoId: resource3.data!,
  //       flags: const YoutubePlayerFlags(
  //         autoPlay: true,
  //         mute: true,
  //       ),
  //     );
  //     debugPrint('controller videoId ${controller!.initialVideoId}');
  //     emit(DetailSuccess(resource1.data!.contains(movieId), isPlayerVisible: true));
  //   } else {
  //     debugPrint('detail cubit showVideo resource3 error');
  //   }
  // }
}
