import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/navigation.dart';
import 'firebase_options.dart';

// Just testing if this works...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Auth().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initFirebase();
    return MaterialApp.router(
      routerConfig: Navigation().getRoutingInfo(),
    );
  }
}
