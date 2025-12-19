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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAj4yz_ZEGJgjLYt3TbH3ZwFluPg1SXR28',
    appId: '1:613361007708:web:55e03008d9ec861f87ba99',
    messagingSenderId: '613361007708',
    projectId: 'futuredragon-0',
    authDomain: 'futuredragon-0.firebaseapp.com',
    storageBucket: 'futuredragon-0.firebasestorage.app',
    measurementId: 'G-E9YTPJ1RKL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGevaPIy8zrd-LEvhUio03WHDB35WCINw',
    appId: '1:613361007708:android:72a02fae4d07b48287ba99',
    messagingSenderId: '613361007708',
    projectId: 'futuredragon-0',
    storageBucket: 'futuredragon-0.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDQRTMh0t0PRcIJGnNmMBZ-GW2r8y5399o',
    appId: '1:783365084219:web:9c119b2e82a10ed3df781e',
    messagingSenderId: '783365084219',
    projectId: 'futurehub-0',
    authDomain: 'futurehub-0.firebaseapp.com',
    storageBucket: 'futurehub-0.firebasestorage.app',
    measurementId: 'G-7C43226S15',
  );
}