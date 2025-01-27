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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEw9cpVfP-h6fm0dEtclawuG7D_sByVOE',
    appId: '1:838632393551:android:cc84961155a414a713533a',
    messagingSenderId: '838632393551',
    projectId: 'shaima-dac76',
    databaseURL: 'https://shaima-dac76.firebaseio.com',
    storageBucket: 'shaima-dac76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD63HuofnDLE71Qm_i1PA5fEFdJ2NMp8mQ',
    appId: '1:838632393551:ios:87a362346572cd9e13533a',
    messagingSenderId: '838632393551',
    projectId: 'shaima-dac76',
    databaseURL: 'https://shaima-dac76.firebaseio.com',
    storageBucket: 'shaima-dac76.appspot.com',
    androidClientId: '838632393551-0bf0fvbddfrm2odcbbtol9gsr6oncd6m.apps.googleusercontent.com',
    iosBundleId: 'com.bikeapp.www.bikeApp',
  );
}
