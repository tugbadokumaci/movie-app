// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/search_page/search_cubit.dart';
import 'package:movie_app/pages/search_page/search_state.dart';
import 'package:movie_app/utils/constants.dart';

import '../../inheritance/mixin_logout.dart';
import '../../utils/theme_utilitys.dart';
import '../../widget/movie_containers_utils.dart';
import '../../widget/navigator_utils.dart';

class SearchView extends StatelessWidget with ILogout {
  SearchCubit viewModel;
  SearchView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  Scaffold _buildScaffold(BuildContext context) {
    viewModel.getTrendingMovie();
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.darkGrey,
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Icon(Icons.home, color: Colors.white),
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
                    navigateToNewRoute(context, searchRoute, null);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fav');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white),
                  onPressed: () {
                    logout();
                    Navigator.pushNamed(context, '/logIn');
                    // Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Search Movie',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: mySearchBar(),
              ),
              BlocConsumer<SearchCubit, SearchState>(listener: (context, state) {
                if (state is SearchInitial) {}
              }, builder: (context, state) {
                if (state is SearchInitial) {
                  return _buildInitial(context);
                } else if (state is SearchLoading) {
                  // return _buildLoading();
                } else if (state is SearchSuccess) {
                  return _buildSuccess(context);
                }
                return Container();
              })
            ],
          ),
        ));
  }

  Widget _buildInitial(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mySizedBoxSmall(),
          Text('Most Searched Movies', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
          mySizedBoxSmall(),
          verticalMovieContainer(viewModel.resource2, context, ''),
        ],
      ),
    ); // display trending movies
  }

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: verticalMovieContainer(viewModel.resource1, context, 'No Result Found'), // display query result
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LinearProgressIndicator(
        color: CustomColors.white,
        backgroundColor: CustomColors.red,
      ),
    );
  }

  Widget mySearchBar() {
    return TextField(
      controller: viewModel.searchController,
      //onChanged: (value) => viewModel.searchUsers(value),
      onChanged: (value) {
        viewModel.searchMovies(value);
      },
      decoration: customInputDecoration(),
      cursorColor: Colors.red,
      style: (const TextStyle(color: Colors.white)),
    );
  }

  InputDecoration customInputDecoration() {
    return InputDecoration(
      prefixIcon: const Icon(Icons.search, color: Colors.red),
      suffixIcon: const Icon(Icons.send, color: Colors.red),
      hintText: 'Search Movie',
      hintStyle: const TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
