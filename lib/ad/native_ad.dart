/*import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'theme.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({super.key});

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    _nativeAd = NativeAd(
      adUnitId: '',
      factoryId: 'listTile', // افتراضي NativeAdFactory
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Native Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _nativeAd!.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded) {
      return const SizedBox(height: 100); // مساحة الإعلان أثناء التحميل
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? ATheme.phoenixGradientDark
            : ATheme.phoenixGradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ATheme.phoenixStart.withAlpha(40),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: AdWidget(ad: _nativeAd!),
      ),
    );
  }
}

/// --- Container لتنسيق الإعلان مع تصميم التطبيق ---
Widget nativeAdCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: const NativeAdWidget(),
  );
}*/
