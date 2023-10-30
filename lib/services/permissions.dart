import 'package:location/location.dart';
import 'package:silencer/services/location.dart';
import 'package:sound_mode/permission_handler.dart';

class Permissions {
  static Future<bool> ringPermissionGranted() async {
    bool? isGranted = await PermissionHandler.permissionsGranted;
    if (isGranted != null) {
      if (!isGranted) {
        await PermissionHandler.openDoNotDisturbSetting();
        bool? grantedNow = await PermissionHandler.permissionsGranted;
        if (grantedNow != null) {
          if (grantedNow) {
            isGranted = true;
          }
        }
      }
      return isGranted;
    } else {
      return false;
    }
  }

  static Future<bool> locationPermissionGranted() async {
    bool serviceEnabled = await LocationService.location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await LocationService.location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    dynamic permissionGranted = await LocationService.location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      permissionGranted = await LocationService.location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
