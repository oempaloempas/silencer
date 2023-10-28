import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class Background {
  static Background? instance;
  late FlutterBackgroundService service;
  // Only for android yet
  Future<void> init() async {
    instance = this;
    service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
    }

    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
            title: 'Testing Background',
            content: 'Last updated: ${DateTime.now()}');
      }
    });
  }
}
