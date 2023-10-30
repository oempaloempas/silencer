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

  static Future<double> getDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
    int maxdistance,
  ) async {
    double distance =
        acos(sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon2 - lon1)) *
            6371; // The formula to get the distance between 2 places
    return distance;
  }
}
