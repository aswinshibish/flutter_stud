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
    apiKey: 'AIzaSyBzN6XDWzvN3SbJNs_b_PHCe1LLcDad1ZU',
    appId: '1:56784976325:web:8306d3028a130f736033ac',
    messagingSenderId: '56784976325',
    projectId: 'clickz-705aa',
    authDomain: 'clickz-705aa.firebaseapp.com',
    databaseURL: 'https://clickz-705aa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'clickz-705aa.appspot.com',
    measurementId: 'G-VN91J4CD52',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsi1lRBdzCH0Qz_0NrxbpQz0_1g9TaE5g',
    appId: '1:56784976325:android:a6a1b46b31395b236033ac',
    messagingSenderId: '56784976325',
    projectId: 'clickz-705aa',
    databaseURL: 'https://clickz-705aa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'clickz-705aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4V2K34oaO1ndE_6I2nMJD3jsgM_K8ZIo',
    appId: '1:56784976325:ios:1dad1e417ad917666033ac',
    messagingSenderId: '56784976325',
    projectId: 'clickz-705aa',
    databaseURL: 'https://clickz-705aa-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'clickz-705aa.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
