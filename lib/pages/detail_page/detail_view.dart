// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme_utilitys.dart';
import 'package:movie_app/utils/utils.dart';
import 'detail_cubit.dart';
import 'detail_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailView extends StatelessWidget {
  int movieId;
  DetailCubit viewModel;
  DetailView({super.key, required this.viewModel, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailCubit>(
      create: (_) => viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(context) {
    return SafeArea(
        child: BlocConsumer<DetailCubit, DetailState>(
            listener: (context, state) {},
            builder: (context, state) {
              debugPrint('detail page state is $state');
              if (state is DetailInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  viewModel.getMovieDetail(movieId);
                  // viewModel.showVideo(movieId);
                });

                // return _buildInitial(context);
              } else if (state is DetailLoading) {
                // return _buildLoading();
              } else if (state is DetailSuccess) {
                return _buildSuccess(context, state.isFav);
              }
              return Container();
            }));
  }

  Scaffold _buildSuccess(BuildContext context, bool isFav) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.resource2.data!.title ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                viewModel.updateFavList(viewModel.resource2.data!.id!);
              },
              icon: Icon(Icons.favorite, color: isFav ? Colors.red : Colors.white)),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Image.network('https://image.tmdb.org/t/p/original${viewModel.resource2.data!.backdropPath}'),
                ),
                mySizedBoxMedium(),
                Text(viewModel.resource2.data!.originalTitle ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
                mySizedBoxMedium(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(viewModel.resource2.data!.overview ?? ''),
                ),
                mySizedBoxSmall(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.thumb_down, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(viewModel.resource2.data!.voteAverage.toString(),
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(width: 10),
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 10),
                    Text(viewModel.resource2.data!.voteCount.toString(), style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(width: 10),
                    const Icon(Icons.thumb_up, color: Colors.grey),
                  ],
                ),
                mySizedBoxMedium(),
                MyButton().myRedButton(
                    context: context,
                    height: 50,
                    width: 350,
                    label: 'Watch Now',
                    onPressed: () {
                      // await viewModel.showVideo(movieId); // open video
                      // // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            debugPrint('controller after pressing watch button' + viewModel.controller.toString());
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Trailer Player'),
                                  YoutubePlayer(
                                    controller: viewModel.controller!,
                                    showVideoProgressIndicator: true,
                                    progressColors: const ProgressBarColors(
                                      playedColor: Colors.red,
                                      handleColor: Colors.red,
                                    ),
                                    onReady: () {
                                      viewModel.controller!.addListener(listener);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listener() {
    debugPrint('on ready controller values:::::: ${viewModel.controller.toString()}');
    debugPrint('on ready controller videoId:::::: ${viewModel.controller!.initialVideoId}');

    if (viewModel.controller!.value.isReady) {
      viewModel.controller!.play();
    }
  }
}
