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
    apiKey: 'AIzaSyBPKNi7gOqzTTCjx8rbPoDdKaIIEyFDhe4',
    appId: '1:372070973550:web:4234bbd81c61d11338a67f',
    messagingSenderId: '372070973550',
    projectId: 'silencerapp-3012',
    authDomain: 'silencerapp-3012.firebaseapp.com',
    storageBucket: 'silencerapp-3012.appspot.com',
    measurementId: 'G-CQBZWCWEDM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKLqruFIjy7xCEb5s3JoZUaEPIGwBRBgs',
    appId: '1:372070973550:android:ad9b2877a3473cd238a67f',
    messagingSenderId: '372070973550',
    projectId: 'silencerapp-3012',
    storageBucket: 'silencerapp-3012.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeAadoZ3yMi9Ceo6J8uKxOgvQLyiKVG8w',
    appId: '1:372070973550:ios:663a64ae79ad96ee38a67f',
    messagingSenderId: '372070973550',
    projectId: 'silencerapp-3012',
    storageBucket: 'silencerapp-3012.appspot.com',
    androidClientId: '372070973550-cobq3d63ov63b8cdl64ololqp74r93fd.apps.googleusercontent.com',
    iosClientId: '372070973550-400h5q7nemhoqmgsfn3lfm32sbb6ii0t.apps.googleusercontent.com',
    iosBundleId: 'com.example.silencer',
  );
}
