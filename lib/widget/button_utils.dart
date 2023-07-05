// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  BuildContext context;
  double height;
  double width;
  String label;
  void Function()? onPressed;
  MyButtonWidget({
    super.key,
    required this.context,
    required this.height,
    required this.width,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,

      // margin: const EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.red, shape: BoxShape.rectangle),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
