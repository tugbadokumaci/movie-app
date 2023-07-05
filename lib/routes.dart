// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail_page/detail_cubit.dart';
import 'package:movie_app/pages/detail_page/detail_repository.dart';
import 'package:movie_app/pages/detail_page/detail_view.dart';
import 'package:movie_app/pages/fav_page/fav_cubit.dart';
import 'package:movie_app/pages/fav_page/fav_repository.dart';
import 'package:movie_app/pages/fav_page/fav_view.dart';

import 'package:movie_app/pages/home_page/home_cubit.dart';
import 'package:movie_app/pages/home_page/home_repository.dart';
import 'package:movie_app/pages/home_page/home_view.dart';
import 'package:movie_app/pages/login_page/login_cubit.dart';
import 'package:movie_app/pages/login_page/login_repository.dart';
import 'package:movie_app/pages/login_page/login_view.dart';
import 'package:movie_app/pages/search_page/search_cubit.dart';
import 'package:movie_app/pages/search_page/search_repository.dart';
import 'package:movie_app/pages/search_page/search_view.dart';
import 'package:movie_app/pages/settings_page/settings_view.dart';
import 'package:movie_app/pages/signup_page/signup_cubit.dart';
import 'package:movie_app/pages/signup_page/signup_repository.dart';
import 'package:movie_app/pages/signup_page/signup_view.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/utils/constants.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => LoginView(
                  viewModel: LoginCubit(repo: locator.get<LoginRepository>()),
                ));
      case signupRoute:
        return MaterialPageRoute(
            builder: (_) => SignupView(
                  viewModel: SignupCubit(repo: locator.get<SignupRepository>()),
                ));
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => HomeView(
                  viewModel: HomeCubit(repo: locator.get<HomeRepository>()),
                ));
      // case detailRoute:
      //   Results movie = settings.arguments as Results;
      //   return MaterialPageRoute(builder: (_) => DetailView(movie: movie));
      case detailRoute:
        int movieId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DetailView(
                  viewModel: DetailCubit(repo: locator.get<DetailRepository>()),
                  movieId: movieId,
                ));
      case favRoute:
        return MaterialPageRoute(
            builder: (_) => FavView(
                  viewModel: FavCubit(repo: locator.get<FavRepository>()),
                ));
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case searchRoute:
        return MaterialPageRoute(
            builder: (_) => SearchView(
                  viewModel: SearchCubit(repo: locator.get<SearchRepository>()),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
