import 'package:flutter/material.dart';

mixin NavigatorManager {
  // constructor sız class
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: const RouteSettings()));
  }

  Future<T?> navigateToWidgetNormal<T>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: const RouteSettings()));
  }
}

void navigateToNewRoute(BuildContext context, String newRouteName) {
  final currentRoute = ModalRoute.of(context)?.settings.name;
  debugPrint(currentRoute); // null
  debugPrint(newRouteName);
  if (currentRoute != newRouteName) {
    Navigator.pushNamed(context, newRouteName);
  }
}
