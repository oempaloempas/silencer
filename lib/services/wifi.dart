import 'package:wifi_scan/wifi_scan.dart';

class Wifi {
  static Future<bool> tryFindMatch(String matchingSSID) async {
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    if (can == CanGetScannedResults.yes) {
      final accesPoints = await WiFiScan.instance.getScannedResults();
      for (var x in accesPoints) {
        if (x.ssid == matchingSSID) {
          return true;
        }
      }
    }
    return false;
  }
}
