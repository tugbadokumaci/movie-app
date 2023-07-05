// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/widget/movie_containers_utils.dart';

import '../../models/movie_result_model.dart';
import '../../utils/resource.dart';
import '../../utils/theme_utilitys.dart';
import 'fav_cubit.dart';
import 'fav_state.dart';

class FavView extends StatelessWidget {
  FavView({super.key, required this.viewModel});
  FavCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavCubit>(
      create: (_) => viewModel,
      child: _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Your Likes')),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: BlocConsumer<FavCubit, FavState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FavInitial) {
                viewModel.getFavorites();
                // return _buildInitial();
              } else if (state is FavLoading) {
                return _buildLoading();
              } else if (state is FavSuccess) {
                return _buildSuccess(context);
              }
              return Container();
            },
          ),
        ));
  }

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // mySizedBoxSmall(),
          // Text('Your Likes', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white)),
          // mySizedBoxSmall(),
          // CircleAvatar(
          //     backgroundImage: Image(
          //   image: viewModel.image,
          // )),
          CircleAvatar(backgroundImage: viewModel.image!.image),
          favContainer(viewModel.resource1, context),
        ],
      ),
    );
  }

  Widget favContainer(Resource<MovieResultModel> resource, BuildContext context) {
    if (resource.status == Status.LOADING) {
      return const CircularProgressIndicator();
    } else if (resource.status == Status.SUCCESS) {
      if (resource.data!.results!.isNotEmpty) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resource.data!.results!.length,
          itemBuilder: (context, index) {
            final movie = resource.data!.results![index];
            return GestureDetector(
              onTap: () {
                // viewModel.getFavorites();
                // Navigator.pushNamed(context, '/detail', arguments: movie.id);
                // viewModel.refreash();

                _navigateAndUpdateFavorites(context, movie.id ?? 0);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.grey[900],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: movie.backdropPath == null
                                ? const Icon(Icons.error_outline)
                                : Image.network('https://image.tmdb.org/t/p/original/${movie.backdropPath}')),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(movie.title.toString(), style: Theme.of(context).textTheme.titleLarge),
                              Row(
                                children: [
                                  Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall),
                                  const Icon(Icons.star, color: Colors.yellow),
                                  Text(movie.voteCount.toString(), style: Theme.of(context).textTheme.titleSmall)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            );
          },
        );
      } else {
        return Center(
            child: Column(
          children: [
            mySizedBoxMedium(),
            Text('Your favorites list is empty'),
          ],
        ));
      }
    } else if (resource.status == Status.ERROR) {
      return Text(resource.errorMessage.toString());
    }
    return Container();
  }

  // Widget favContainer(Resource<MovieResultModel> resource, BuildContext context) {
  //   if (resource.status == Status.LOADING) {
  //     return const CircularProgressIndicator();
  //   } else if (resource.status == Status.SUCCESS) {
  //     if (resource.data!results.isNotEmpty) {
  //       return ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: resource.data!.length,
  //         itemBuilder: (context, index) {
  //           final movie = resource.data![index];
  //           return GestureDetector(
  //             onTap: () {
  //               // viewModel.getFavorites();
  //               // Navigator.pushNamed(context, '/detail', arguments: movie.id);
  //               // viewModel.refreash();

  //               _navigateAndUpdateFavorites(context, movie.id ?? 0);
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 15.0),
  //               child: Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   margin: const EdgeInsets.symmetric(horizontal: 8),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     // color: Colors.grey[900],
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                           child: movie.backdropPath == null
  //                               ? const Icon(Icons.error_outline)
  //                               : Image.network('https://image.tmdb.org/t/p/original/${movie.backdropPath}')),
  //                       const SizedBox(width: 10),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //                             Text(movie.title.toString(), style: Theme.of(context).textTheme.titleLarge),
  //                             Row(
  //                               children: [
  //                                 Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall),
  //                                 const Icon(Icons.star, color: Colors.yellow),
  //                                 Text(movie.voteCount.toString(), style: Theme.of(context).textTheme.titleSmall)
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   )),
  //             ),
  //           );
  //         },
  //       );
  //     } else {
  //       return Center(
  //           child: Column(
  //         children: [
  //           mySizedBoxMedium(),
  //           Text('Your favorites list is empty'),
  //         ],
  //       ));
  //     }
  //   } else if (resource.status == Status.ERROR) {
  //     return Text(resource.errorMessage.toString());
  //   }
  //   return Container();
  // }

  Future<void> _navigateAndUpdateFavorites(BuildContext context, int movieId) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/detail', arguments: movieId);

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    // if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
    viewModel.refreash();
  }

  Widget _buildLoading() {
    return Center(
      child: LinearProgressIndicator(
        color: CustomColors.white,
        backgroundColor: CustomColors.red,
      ),
    );
  }
}
