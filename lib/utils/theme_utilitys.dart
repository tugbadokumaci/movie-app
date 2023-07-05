import 'package:flutter/material.dart';

class CustomColors {
  static Color red = Colors.red;
  static Color darkGrey = const Color.fromARGB(255, 52, 52, 52);
  static Color white = Colors.white;
  static Color black = Colors.black;
}

class IconSizes {
  static double large = 80;
  static double medium = 50;
  static double small = 20;
}

SizedBox mySizedBoxLarge() => const SizedBox(height: 80, width: 80);
SizedBox mySizedBoxMedium() => const SizedBox(height: 50, width: 50);
SizedBox mySizedBoxSmall() => const SizedBox(height: 20, width: 20);
