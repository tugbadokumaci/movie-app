// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDK6f3ENf8cI5nL5FCtE3h9h5Fa-DtO_4g',
    appId: '1:655215874981:web:46fe658c9d93166f0e4e4c',
    messagingSenderId: '655215874981',
    projectId: 'movie-app-858f5',
    authDomain: 'movie-app-858f5.firebaseapp.com',
    storageBucket: 'movie-app-858f5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7WXVKAGcC6S4XMFL5pc6uBmLaSrM0JPM',
    appId: '1:655215874981:android:4d63208d1b2d8e300e4e4c',
    messagingSenderId: '655215874981',
    projectId: 'movie-app-858f5',
    storageBucket: 'movie-app-858f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZ8xB16V34W1E1HoaaiqabeOQINzJpdw4',
    appId: '1:655215874981:ios:ad156cf2d189528a0e4e4c',
    messagingSenderId: '655215874981',
    projectId: 'movie-app-858f5',
    storageBucket: 'movie-app-858f5.appspot.com',
    iosClientId: '655215874981-n05316uggsugiujmv3o7rvpo5celetn4.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZ8xB16V34W1E1HoaaiqabeOQINzJpdw4',
    appId: '1:655215874981:ios:b41271a4693805d70e4e4c',
    messagingSenderId: '655215874981',
    projectId: 'movie-app-858f5',
    storageBucket: 'movie-app-858f5.appspot.com',
    iosClientId: '655215874981-jr86jshqfr9qsua9v9q5kn11l6v6i2mm.apps.googleusercontent.com',
    iosBundleId: 'com.example.movieApp.RunnerTests',
  );
}
