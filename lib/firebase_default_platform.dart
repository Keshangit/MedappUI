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
      apiKey: "AIzaSyCDTukUayUpLCvhSHOdVmGhjH8rdqHN1KQ",
      databaseURL: "",
      projectId: "tech.teranos.livequizy",
      storageBucket: "",
      messagingSenderId: "113221767753",
      appId: "1:113221767753:android:69b83ad176069adef7e598",
      measurementId: "");

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyCDTukUayUpLCvhSHOdVmGhjH8rdqHN1KQ',
      databaseURL: "",
      projectId: "tech.teranos.livequizy",
      storageBucket: "",
      messagingSenderId: "113221767753",
      appId: "1:113221767753:android:69b83ad176069adef7e598",
      measurementId: "");

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDTukUayUpLCvhSHOdVmGhjH8rdqHN1KQ',
    appId: '1:113221767753:android:69b83ad176069adef7e598',
    messagingSenderId: '113221767753',
    projectId: 'tech.teranos.livequizy',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'xxxxxxxxxxxxxxxxxxx',
    androidClientId: 'xxxxxxxxxxxxxxxxxxx',
    iosClientId: 'xxxxxxxxxxxxxxxxxxx',
    iosBundleId: 'xxxxxxxxxxxxxxxxxxx',
  );
}
