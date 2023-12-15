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
    apiKey: 'AIzaSyDlQE0swm8QSsYQ3NpRZvvdr1KwonSp4L8',
    appId: '1:553618993072:web:8fd4c3c1068df17edbf075',
    messagingSenderId: '553618993072',
    projectId: 'dummy-8314e',
    authDomain: 'dummy-8314e.firebaseapp.com',
    storageBucket: 'dummy-8314e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARGxVp72gFidW_bQ8VdnprCxX-6I2-sb0',
    appId: '1:553618993072:android:c469ad359a495b9edbf075',
    messagingSenderId: '553618993072',
    projectId: 'dummy-8314e',
    storageBucket: 'dummy-8314e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3QJ7HItiGz0ZO2OnB0C8JcWLkQNEgTFo',
    appId: '1:553618993072:ios:b4c42ec0f04f5682dbf075',
    messagingSenderId: '553618993072',
    projectId: 'dummy-8314e',
    storageBucket: 'dummy-8314e.appspot.com',
    iosBundleId: 'com.example.taskProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3QJ7HItiGz0ZO2OnB0C8JcWLkQNEgTFo',
    appId: '1:553618993072:ios:484296f56f30cec1dbf075',
    messagingSenderId: '553618993072',
    projectId: 'dummy-8314e',
    storageBucket: 'dummy-8314e.appspot.com',
    iosBundleId: 'com.example.taskProject.RunnerTests',
  );
}
