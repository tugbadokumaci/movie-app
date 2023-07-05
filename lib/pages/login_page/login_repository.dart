import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/utils/resource.dart';
import '../../models/user_model.dart';

class LoginRepository {
  final firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Resource<UserModel>> logIn(String email, String password) async {
    var userId = '';
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        userId = result.user!.uid;
      }

      DocumentSnapshot snapshot = await firestore.collection('users').doc(userId).get();
      String name = snapshot['name'];
      String surname = snapshot['surname'];

      // snapshot = await firestore.collection('favorites').doc(userId).get();
      // final favList = snapshot['favList'].cast<int>();
      // debugPrint(favList.toString());

      return Resource.success(
          UserModel(email: email, password: password, userId: userId, name: name, surname: surname));
    } on FirebaseAuthException catch (e) {
      return Resource.error(e.message ?? "login repository hata");
    }
  }
}
