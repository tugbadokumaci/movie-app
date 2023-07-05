// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app/utils/theme_utilitys.dart';

class MyTextFieldWidget extends StatelessWidget {
  String? Function(String?) validatorCallback;
  TextEditingController controller;
  String labelText;
  bool isSecure;
  MyTextFieldWidget({
    super.key,
    required this.validatorCallback,
    required this.controller,
    required this.labelText,
    this.isSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorCallback,
      controller: controller,
      style: TextStyle(color: CustomColors.white),
      obscureText: isSecure,
      decoration: InputDecoration(labelText: labelText, floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
