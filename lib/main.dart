import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krishak/firebase_options.dart';
import 'package:krishak/screens/education.dart';
import 'package:krishak/screens/onboarding.dart';
import 'package:krishak/screens/scheme.dart';
import 'package:krishak/screens/signin.dart';
import 'package:krishak/screens/signup.dart';
import 'package:krishak/screens/social.dart';
import 'package:krishak/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        "/onboarding": (context) => const OnBoardingScreen(),
        "/signin": (context) => const SigninScreen(),
        "/signup": (context) => const SignupScreen(),
        "/schemes": (context) => const Scheme(),
        "/education": (context) => const Education(),
        "/community": (context) => const SocialScreen(),
      },
    );
  }
}
