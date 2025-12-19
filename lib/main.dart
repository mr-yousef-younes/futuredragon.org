import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';


import 'firebase_options.dart';
import 'theme.dart';
import 'screens/auth_gate.dart';
import 'screens/create_account.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/course.dart';
import 'screens/privacy.dart';
import 'screens/help.dart';
import 'settings.dart';
import 'screens/community.dart';
import 'start.dart';
import 'screens/email_login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  }
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: FutureHub()));
}

class FutureHub extends ConsumerStatefulWidget {
  const FutureHub({super.key});

  @override
  ConsumerState<FutureHub> createState() => _FutureHubState();
}

class _FutureHubState extends ConsumerState<FutureHub> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/',builder: (context, state) => const AuthGate(),),
        GoRoute(path: '/privacy', builder: (context, state) => const PrivacyPolicyPage()),
        GoRoute(path: '/create', builder: (context, state) => const CreateAccount()),
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
        GoRoute(path: '/help', builder: (context, state) => const HelpPage()),
        GoRoute(path: '/community', builder: (context, state) => const CommunityPage()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/courses', builder: (context, state) => const CoursePage()),
        GoRoute(path: '/start', builder: (context, state) => const Start()),
        GoRoute(path: '/email-login',builder: (context, state) => const EmailLoginPage(),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FutureHub',
      locale: const Locale('ar', 'EG'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'EG'),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ATheme.lightTheme,
      darkTheme: ATheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
