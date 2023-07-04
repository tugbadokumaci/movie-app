// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app/utils/theme_utilitys.dart';

class AASD extends StatelessWidget {
  String? Function(String?) validatorCallback;
  TextEditingController controller;
  String labelText;
  AASD({
    super.key,
    required this.validatorCallback,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorCallback,
      controller: controller,
      style: TextStyle(color: CustomColors.white),
      decoration: InputDecoration(labelText: labelText, floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
