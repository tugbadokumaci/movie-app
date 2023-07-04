import 'package:flutter/material.dart';
import 'package:movie_app/routes.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/utils/theme_utilitys.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: Colors.transparent, elevation: 0.0),
          primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
          // textTheme: Typography.whiteCupertino,
          colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
          bottomAppBarTheme: BottomAppBarTheme(shape: CircularNotchedRectangle()),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
          iconTheme: const IconThemeData(color: Colors.red),
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: CustomColors.darkGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ))),
      onGenerateRoute: RouteGenerator.GenerateRoute,
      initialRoute: loginRoute,
    );
  }
}
