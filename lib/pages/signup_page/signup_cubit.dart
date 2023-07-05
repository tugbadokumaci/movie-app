// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/signup_page/signup_repository.dart';
import 'package:movie_app/pages/signup_page/signup_state.dart';
import 'package:movie_app/utils/constants.dart';
import '../../utils/utils.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _repo;
  SignupCubit({required SignupRepository repo})
      : _repo = repo,
        super(SignupInitial());

  TextEditingController getNameController = TextEditingController();
  TextEditingController getSurnameController = TextEditingController();

  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();

  List<int> image = [];

  Future<void> sigup(BuildContext context) async {
    String result = await _repo.signUp(
        getEmailController.text, getPasswordController.text, getNameController.text, getSurnameController.text, image);
    if (result == "success") {
      Constants.USER.name = getNameController.text;
      Constants.USER.name = getSurnameController.text;
      emit(SignupSuccess());
    } else {
      Utils.showCustomDialog(
        context: context,
        title: 'Sign up Error',
        content: result.toString(),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
