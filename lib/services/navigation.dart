import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:silencer/pages/universal/home.dart';
import 'package:silencer/pages/universal/login.dart';
import 'package:silencer/pages/universal/signup.dart';
import 'package:silencer/pages/universal/welcome.dart';
import 'package:silencer/services/auth.dart';

class Navigation {
  bool fakeIOS = true;

  GoRouter getRoutingInfo() {
    return GoRouter(routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          if (!Auth.signedIn) {
            return '/welcome';
          } else {
            return null;
          }
        },
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const Welcome(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpEmail(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LogInEmail(),
      )
    ]);
  }

  // An function to return a specific page based on the platform
  getPlatformSpecificPage(iOSpage, androidPage) {
    if (Platform.isIOS || fakeIOS) {
      return iOSpage;
    } else {
      // Web uses the android style as default
      return androidPage;
    }
  }
}
