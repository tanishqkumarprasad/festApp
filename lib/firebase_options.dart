import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) return android;
    // Defaulting to android for your current emulator setup
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzUx75FxYy5l7Hkj45vsjV_JC5MDjzGug',
    appId: '1:701930487949:android:522849e0b0edec16fd22c4',
    messagingSenderId: '701930487949',
    projectId: 'festapp-a6c8c',
    storageBucket: 'festapp-a6c8c.firebasestorage.app',
  );
}
