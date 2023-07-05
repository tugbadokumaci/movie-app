import '../shared_preferences_service.dart';

mixin ILogout {
  Future<void> logout() async {
    await SharedPreferencesService.clearLocalStorage();
    // await FirebaseFirestore.instance.collection('favorites').doc(Constants.USER.userId).update({
    //   'favList': Constants.USER.favList,
    // });
  }
}
