// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDqiX6D8C2wq54FllSO7BCjHL9Zy1lel0o',
    appId: '1:720981249940:web:e89fd1c2112feb7d2ec981',
    messagingSenderId: '720981249940',
    projectId: 'la-beta',
    authDomain: 'la-beta.firebaseapp.com',
    databaseURL: 'https://la-beta-default-rtdb.firebaseio.com',
    storageBucket: 'la-beta.appspot.com',
    measurementId: 'G-2VS58LJ2HW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7TPuio80DBWl6-7tdeSKMK9zX6jgaqFw',
    appId: '1:720981249940:android:b3f7742377bdd4b22ec981',
    messagingSenderId: '720981249940',
    projectId: 'la-beta',
    databaseURL: 'https://la-beta-default-rtdb.firebaseio.com',
    storageBucket: 'la-beta.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSGZqxcnkX-GbqViCuPnNY7GeKKt0Fy8c',
    appId: '1:720981249940:ios:d46ca507c316bc482ec981',
    messagingSenderId: '720981249940',
    projectId: 'la-beta',
    databaseURL: 'https://la-beta-default-rtdb.firebaseio.com',
    storageBucket: 'la-beta.appspot.com',
    iosBundleId: 'com.duendevelopments.labeta',
  );

}