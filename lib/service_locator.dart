import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/pages/detail_page/detail_repository.dart';
import 'package:movie_app/pages/fav_page/fav_repository.dart';
import 'package:movie_app/pages/home_page/home_repository.dart';
import 'package:movie_app/pages/login_page/login_repository.dart';
import 'package:movie_app/pages/search_page/search_repository.dart';
import 'package:movie_app/pages/signup_page/signup_repository.dart';

import 'generator.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));
    locator.registerFactory<LoginRepository>(() => LoginRepository());
    locator.registerFactory<SignupRepository>(() => SignupRepository());
    locator.registerFactory<HomeRepository>(() => HomeRepository(locator<RestClient>()));
    locator.registerFactory<FavRepository>(() => FavRepository(locator<RestClient>()));
    locator.registerFactory<SearchRepository>(() => SearchRepository(locator<RestClient>()));
    locator.registerFactory<DetailRepository>(() => DetailRepository(locator<RestClient>()));
  }
}
