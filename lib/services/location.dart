import 'dart:math';

import 'package:location/location.dart';
import 'package:silencer/services/logging.dart';
import 'package:silencer/services/permissions.dart';

class LocationService {
  static Location location = Location();

  static Future<void> init() async {
    if (await Permissions.locationPermissionGranted() != true) {
      Logging.warningLog('Location service is not enabled', trace: false);
    }
  }

  static Future<LocationData> getLocation() async {
    return await location.getLocation();
  }

  static bool inRange(lat1, lon1, lat2, lon2, maxrange) {
    if (getDistanceInM(lat1, lon1, lat2, lon2) < maxrange) {
      return true;
    } else {
      return false;
    }
  }

  static double getDistanceInM(lat1, lon1, lat2, lon2) {
    double R = 6371000; // Radius of the earth in m
    double dLat = deg2rad(lat2 - lat1); // deg2rad below
    double dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  static double deg2rad(deg) {
    return deg * (pi / 180);
  }
}
