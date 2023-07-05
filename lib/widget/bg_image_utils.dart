// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  Shader Function(Rect) shaderCallback;
  BackgroundImage({super.key, required this.shaderCallback});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: shaderCallback,
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/movie_app_login_screen.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
