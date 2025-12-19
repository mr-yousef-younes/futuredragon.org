import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class InterstitialAdService {
  static InterstitialAd? _interstitialAd;

  static void loadAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-1992836278437597/7577253712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('Interstitial Ad Loaded');
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial Ad failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  static void showAd(BuildContext context, VoidCallback onAdClosed) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              loadAd(); // إعادة تحميل إعلان جديد
              onAdClosed();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial Ad failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
              loadAd();
              onAdClosed();
            },
          );

      _interstitialAd!.show();
    } else {

      onAdClosed();
    }
  }
}
