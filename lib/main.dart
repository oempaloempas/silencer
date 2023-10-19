import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/logging.dart';
import 'package:silencer/services/navigation.dart';
import 'firebase_options.dart';

// Just testing if this works...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  if (kReleaseMode) {
    Logging.changeLogLevel(Level.error);
  } else {
    Logging.changeLogLevel(Level.all);
  }
  Logging.infoLog('If you see this message, this is a debug build');
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
