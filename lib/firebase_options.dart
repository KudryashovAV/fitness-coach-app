import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDZfO0F4gJxE8kZVqVWnxzDqEBNKQ4ezug',
    appId: '1:96391412942:android:762a02c40211cb847c249f',
    messagingSenderId: '96391412942',
    projectId: 'free-fitness-coach-app',
    storageBucket: 'free-fitness-coach-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoy4EA4mGjwAWQTiqzxCgBdiUpS3VoBRo',
    appId: '1:96391412942:ios:7742e64b8b7be37a7c249f',
    messagingSenderId: '96391412942',
    projectId: 'free-fitness-coach-app',
    storageBucket: 'free-fitness-coach-app.firebasestorage.app',
    iosBundleId: 'com.example.fitnessCoachApp',
  );
}
