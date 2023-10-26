import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:sound_mode/permission_handler.dart';

class Soundmode {
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

  static Future<void> setRingMode(RingerModeStatus ringMode) async {
    await SoundMode.setSoundMode(ringMode);
  }

  static Future<RingerModeStatus> getRingMode() async {
    return await SoundMode.ringerModeStatus;
  }
}
