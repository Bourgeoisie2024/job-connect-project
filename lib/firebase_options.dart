// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: dotenv.get('FIREBASE_API_KEY_ANDROID'),
        appId: dotenv.get('FIREBASE_APP_ID_ANDROID'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID_ANDROID'),
        projectId: dotenv.get('FIREBASE_PROJECT_ID_ANDROID'),
        storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET_ANDROID'),
      );

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: dotenv.get('FIREBASE_API_KEY_WEB'),
        appId: dotenv.get('FIREBASE_APP_ID_WEB'),
        messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID_WEB'),
        projectId: dotenv.get('FIREBASE_PROJECT_ID_WEB'),
        authDomain: dotenv.get('FIREBASE_AUTH_DOMAIN_WEB'),
        storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET_WEB'),
      );
}
