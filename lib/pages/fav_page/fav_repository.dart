import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/constants.dart';

import '../../generator.dart';
import '../../models/movie_result_model.dart';
import '../../shared_preferences_service.dart';
import '../../utils/resource.dart';

const apiKey = ApiConstants.API_KEY;

class FavRepository {
  RestClient client;
  FavRepository(this.client);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Resource<MovieResultModel>> getFavorites() async {
    List<Results> favMovieList = [];

    try {
      DocumentSnapshot snapshot = await firestore.collection('favorites').doc(Constants.USER.userId).get();
      List<int> favList = snapshot['favList'].cast<int>();
      // final favList = Constants.USER.favList;

      if (favList.isNotEmpty) {
        for (int movieId in favList) {
          final result = await client.getMovieDetail(apiKey, movieId);

          favMovieList.add(result);
        }
      }
      await firestore.collection('favorites').doc(Constants.USER.userId).update({
        'favList': favList,
      });

      return Resource.success(MovieResultModel(results: favMovieList));
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<Image>> getImage() async {
    final image = await SharedPreferencesService.getImage();
    return Resource.success(image);
  }
}

// TO-DO: LOG OUT OLURKEN CONST.FAVLİST -> DB KAYDET
