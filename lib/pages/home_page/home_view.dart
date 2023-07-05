// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/theme_utilitys.dart';

import '../../inheritance/mixin_logout.dart';
import '../../models/genre_model.dart';
import '../../utils/resource.dart';
import '../../widget/movie_containers_utils.dart';
import '../../widget/navigator_utils.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget with ILogout {
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.black,
          floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomColors.darkGrey,
            onPressed: () {
              // Navigator.pushNamed(context, '/');
              navigateToNewRoute(context, '/', null);
            },
            child: const Icon(Icons.home, color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                debugPrint('Home View State is : $state');
                if (state is HomeInitial) {
                  viewModel.getTrendingMovie();
                  viewModel.getNowPlayingMovie();
                  viewModel.getGenreList();
                  viewModel.getWithGenres(viewModel.selectedGenre); // action by deafult
                  // return _buildInitial(context);
                } else if (state is HomeLoading) {
                  return _buildLoading();
                } else if (state is HomeSuccess) {
                  return _buildSuccess(context);
                } else if (state is HomeError) {
                  // return _buildError();
                }
                return Container();
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/search');
                      navigateToNewRoute(context, '/search', null);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/fav');
                      navigateToNewRoute(context, '/fav', null);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout_outlined, color: Colors.white),
                    onPressed: () {
                      logout();
                      navigateToNewRoute(context, '/logIn', null);
                      // Navigator.pushNamed(context, '/logIn');
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
            ),

            //     BottomNavigationBar(
            //   selectedItemColor: CustomColors.white,
            //   unselectedItemColor: Colors.grey,
            //   onTap: (int index) {
            //     if (index == Pages.home.index) {
            //       Navigator.pushNamed(context, '/');
            //     } else if (index == Pages.search.index) {
            //       Navigator.pushNamed(context, '/search');
            //     } else if (index == Pages.favorites.index) {
            //       Navigator.pushNamed(context, '/favorites');
            //     } else {
            //       Navigator.pushNamed(context, '/settings');
            //     }
            //   },
            //   items: const [
            //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
            //   ],
            // ),
          )),
    );
  }

  // Widget _buildInitial(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 16.0),
  //             child: Text('Now Playing Movies',
  //                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold))),
  //         const SizedBox(height: 8),
  //         movieContainer(viewModel.resource1),
  //         const SizedBox(height: 16),
  //         Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 16.0),
  //             child: Text('Trending Movies',
  //                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold))),
  //         const SizedBox(height: 8),
  //         movieContainer(viewModel.resource2),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, size: 60, color: Colors.red),
                    Text(
                      'Movie',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontFamily: 'Limelight',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                // mySizedBoxSmall(),
                // Row(
                //   children: [
                //     const CircleAvatar(
                //       child: Icon(Icons.person, color: Colors.black),
                //       backgroundColor: Colors.white,
                //     ),
                //     const SizedBox(width: 10),
                //     const SizedBox(width: 10),
                //     Text('${Constants.USER.name} ${Constants.USER.surname} ',
                //         style: Theme.of(context).textTheme.displaySmall),
                //   ],
                // ),
              ],
            ),
          ),
          mySizedBoxSmall(),
          containerTitle(context, 'Now Playing Movies'),
          mySizedBoxSmall(),
          horizontalMovieContainer(viewModel.resource1),
          mySizedBoxSmall(),
          containerTitle(context, 'Trending Movies'),
          mySizedBoxSmall(),
          horizontalMovieContainer(viewModel.resource2),
          mySizedBoxSmall(),
          containerTitle(context, 'Movie Categories'),
          mySizedBoxSmall(),
          selectGenreContainer(viewModel.resource3),
          mySizedBoxSmall(),
          containerTitle(context, '${viewModel.selectedGenre.name} Movies'),
          mySizedBoxSmall(),
          verticalMovieContainer(viewModel.resource4, context, 'No movie found for this genre'),
        ],
      ),
    );
  }

  Padding containerTitle(BuildContext context, String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(title,
            style:
                Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)));
  }

  // Widget horizontalMovieContainer(Resource<MovieResultModel> resource) {
  //   if (resource.status == Status.LOADING) {
  //     return const CircularProgressIndicator();
  //   } else if (resource.status == Status.SUCCESS) {
  //     return SizedBox(
  //       height: 230,
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: resource.data!.results!.length,
  //         itemBuilder: (context, index) {
  //           final movie = resource.data!.results![index];
  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.pushNamed(context, '/detail', arguments: movie);
  //             },
  //             child: Container(
  //               // color: Colors.red,
  //               width: 130,
  //               margin: const EdgeInsets.symmetric(horizontal: 8),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 190,
  //                     child: Image.network(
  //                       'https://image.tmdb.org/t/p/original${movie.posterPath}',
  //                       fit: BoxFit.fitHeight,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     movie.title ?? 'null title',
  //                     style: const TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   } else if (resource.status == Status.ERROR) {
  //     return Text(resource.errorMessage.toString());
  //   }
  //   return Container();
  // }

  Widget selectGenreContainer(Resource<GenreModel> resource) {
    if (resource.status == Status.LOADING) {
      return const CircularProgressIndicator();
    } else if (resource.status == Status.SUCCESS) {
      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: resource.data!.genres!.length,
          itemBuilder: (context, index) {
            final genre = resource.data!.genres![index];
            return Container(
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    _handleButtonPressed(context, genre);
                  },
                  child: Text(genre.name ?? 'genre null',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                ));
          },
        ),
      );
    } else if (resource.status == Status.ERROR) {
      return Text(resource.errorMessage.toString());
    }
    return Container();
  }

  void _handleButtonPressed(BuildContext context, Genres genre) {
    viewModel.getWithGenres(genre);
  }

  Widget _buildLoading() {
    return Center(
      child: LinearProgressIndicator(
        color: CustomColors.white,
        backgroundColor: CustomColors.red,
      ),
    );
  }

  // Widget verticalMovieContainer(Resource<MovieResultModel> resource, BuildContext context) {
  //   if (resource.status == Status.LOADING) {
  //     return const CircularProgressIndicator();
  //   } else if (resource.status == Status.SUCCESS) {
  //     return Container(
  //       height: 3000, // IS IT A GOOD PRACTİCE ???
  //       child: ListView.builder(
  //         scrollDirection: Axis.vertical,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: resource.data!.results!.length,
  //         itemBuilder: (context, index) {
  //           final movie = resource.data!.results![index];
  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.pushNamed(context, '/detail', arguments: movie);
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
  //       ),
  //     );
  //   } else if (resource.status == Status.ERROR) {
  //     return Text(resource.errorMessage.toString());
  //   }
  //   return Container();
  // }
}

enum Pages {
  home,
  search,
  favorites,
  settings,
}
