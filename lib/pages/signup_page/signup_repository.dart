// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared_preferences_service.dart';

class SignupRepository {
  final firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password, String name, String surname, List<int>? image) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // Set additional user information
      User user = result.user!;
      String uid = user.uid;
      user.updateDisplayName('$name $surname'); // NOT USED
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'surname': surname,
      });
      await FirebaseFirestore.instance.collection('favorites').doc(uid).set({
        'favList': [],
      });

      await SharedPreferencesService.setStringPreference(email, password);
      if (image != null) {
        await SharedPreferencesService.saveImage(image);
      }
      return "success";
    } on FirebaseAuthException catch (e) {
      return "${e.message}";
    }
  }
}
