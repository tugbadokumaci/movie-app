import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/utils/resource.dart';
import '../../generator.dart';
import '../../inheritance/mixin_movie_feature.dart';
import '../../models/video_model.dart';
import '../../utils/constants.dart';

const apiKey = ApiConstants.API_KEY;

class DetailRepository with MixinMovieFeature {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RestClient client;
  DetailRepository(this.client);

  Future<Resource<List<int>>> getFavList() async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('favorites').doc(Constants.USER.userId).get();
      final favList = snapshot['favList'].cast<int>();

      // if (favList.contains(movieId)) {
      //   favList.remove(movieId);
      // } else {
      //   favList.add(movieId);
      // }
      return Resource.success(favList);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<int>>> setFavList(List<int> favList) async {
    try {
      await firestore.collection('favorites').doc(Constants.USER.userId).update({'favList': favList});

      return Resource.success(favList);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> getYoutubeId(int movieId) async {
    try {
      VideoModel video = await client.getYoutubeId(apiKey, movieId);
      return Resource.success(video.results!.first.key!);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }
}
