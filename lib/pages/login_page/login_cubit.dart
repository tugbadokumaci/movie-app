// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../shared_preferences_service.dart';
import '../../utils/constants.dart';
import '../../utils/resource.dart';
import '../../utils/utils.dart';
import 'login_repository.dart';
import 'login_state.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repo;

  LoginCubit({
    required LoginRepository repo,
  })  : _repo = repo,
        super(LoginInitial());

  TextEditingController getEmailController = TextEditingController();
  TextEditingController getPasswordController = TextEditingController();

  Future<void> initialize() async {
    await SharedPreferencesService.initialize();
    getEmailController.text = await SharedPreferencesService.getEmailPreference();
    getPasswordController.text = await SharedPreferencesService.getPasswordPreference();
  }

  Future<void> login(BuildContext context) async {
    final email = getEmailController.text;
    final password = getPasswordController.text;

    Resource<UserModel> resource = await _repo.logIn(email, password);
    debugPrint('${resource.status}');
    if (resource.status == Status.SUCCESS) {
      SnackBar(content: Text('log in success'));
      emit(LoginSuccess());
      await SharedPreferencesService.setStringPreference(
        email,
        password,
      );
      Constants.USER = resource.data!; // çünkü status success
    } else {
      Utils.showCustomDialog(
        context: context,
        title: 'Log in Error',
        content: resource.errorMessage ?? '',
        onTap: () {
          Navigator.of(context).pop();
        },
      );
      // emit(LoginError(response.result));
    }
  }
}
