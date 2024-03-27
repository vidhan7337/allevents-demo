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
    apiKey: 'AIzaSyC626waXMv8GUtl48NVAfeoK-Xz4y68jOE',
    appId: '1:285124501002:web:3e93b8d4fe25185bee89f3',
    messagingSenderId: '285124501002',
    projectId: 'all-events-ed64f',
    authDomain: 'all-events-ed64f.firebaseapp.com',
    storageBucket: 'all-events-ed64f.appspot.com',
    measurementId: 'G-S9G5V3H5S6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbmGkyFHNhhy1h_IH7lImCwjoApJia21A',
    appId: '1:285124501002:android:e7227d7005bc743bee89f3',
    messagingSenderId: '285124501002',
    projectId: 'all-events-ed64f',
    storageBucket: 'all-events-ed64f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgQxCerdO9U3gczS2YY0uB2EZ11ObOBjY',
    appId: '1:285124501002:ios:e9e0a7c5b6dda870ee89f3',
    messagingSenderId: '285124501002',
    projectId: 'all-events-ed64f',
    storageBucket: 'all-events-ed64f.appspot.com',
    iosBundleId: 'com.example.demoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgQxCerdO9U3gczS2YY0uB2EZ11ObOBjY',
    appId: '1:285124501002:ios:f00e0ac72cbf72c5ee89f3',
    messagingSenderId: '285124501002',
    projectId: 'all-events-ed64f',
    storageBucket: 'all-events-ed64f.appspot.com',
    iosBundleId: 'com.example.demoApp.RunnerTests',
  );
}
