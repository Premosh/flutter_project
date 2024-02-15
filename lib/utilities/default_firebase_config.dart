import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyCiZfT8q7aOxKIvyVDmEGGVezhwg908Z4Q",
      authDomain: "whatever-df6f2.firebaseapp.com",
      projectId: "whatever-df6f2",
      storageBucket: "whatever-df6f2.appspot.com",
      messagingSenderId: "852808584085",
      appId: "1:852808584085:web:bc758529eb98788003849c",
      measurementId: "G-DQGWRFP0TC"
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyCiZfT8q7aOxKIvyVDmEGGVezhwg908Z4Q",
      authDomain: "whatever-df6f2.firebaseapp.com",
      projectId: "whatever-df6f2",
      storageBucket: "whatever-df6f2.appspot.com",
      messagingSenderId: "852808584085",
      appId: "1:852808584085:web:bc758529eb98788003849c",
      measurementId: "G-DQGWRFP0TC"
  );

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: "AIzaSyCiZfT8q7aOxKIvyVDmEGGVezhwg908Z4Q",
      authDomain: "whatever-df6f2.firebaseapp.com",
      projectId: "whatever-df6f2",
      storageBucket: "whatever-df6f2.appspot.com",
      messagingSenderId: "852808584085",
      appId: "1:852808584085:web:bc758529eb98788003849c",
      measurementId: "G-DQGWRFP0TC"
  );

}