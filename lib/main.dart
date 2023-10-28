import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:silencer/pages/universal/background.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/cron.dart';
import 'package:silencer/services/logging.dart';
import 'package:silencer/services/navigation.dart';
import 'package:silencer/services/prefs.dart';

// Just testing if this works...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    Logging.changeLogLevel(Level.error);
  } else {
    Logging.changeLogLevel(Level.all);
  }
  Logging.infoLog('If you see this message, this is a debug build',
      trace: false);
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  await Auth().init();
  await Prefs().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Navigation().getRoutingInfo(),
    );
  }
}
