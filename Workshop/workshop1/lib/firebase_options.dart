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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDYMoW8kDO3N28iAWW67KxenJfkPZA8dQc',
    appId: '1:432998263823:web:6127c0b55b8ed08260c77a',
    messagingSenderId: '432998263823',
    projectId: 'noone456-38b53',
    authDomain: 'noone456-38b53.firebaseapp.com',
    storageBucket: 'noone456-38b53.firebasestorage.app',
    measurementId: 'G-EBKDVH6MCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzJIIkGccump9I3MuQ37c9v3_6c9liPIE',
    appId: '1:432998263823:android:68182128ca931c2160c77a',
    messagingSenderId: '432998263823',
    projectId: 'noone456-38b53',
    storageBucket: 'noone456-38b53.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZuPTWg7hobRhHCoWWj_ESKAezdKZ8VkQ',
    appId: '1:432998263823:ios:ba0332e6aa2ba5de60c77a',
    messagingSenderId: '432998263823',
    projectId: 'noone456-38b53',
    storageBucket: 'noone456-38b53.firebasestorage.app',
    iosBundleId: 'com.example.none34',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZuPTWg7hobRhHCoWWj_ESKAezdKZ8VkQ',
    appId: '1:432998263823:ios:ba0332e6aa2ba5de60c77a',
    messagingSenderId: '432998263823',
    projectId: 'noone456-38b53',
    storageBucket: 'noone456-38b53.firebasestorage.app',
    iosBundleId: 'com.example.none34',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYMoW8kDO3N28iAWW67KxenJfkPZA8dQc',
    appId: '1:432998263823:web:b07bd65e212ac4f960c77a',
    messagingSenderId: '432998263823',
    projectId: 'noone456-38b53',
    authDomain: 'noone456-38b53.firebaseapp.com',
    storageBucket: 'noone456-38b53.firebasestorage.app',
    measurementId: 'G-JYEZZ1RBJ0',
  );
}
