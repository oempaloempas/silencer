import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class Soundmode {
  static Future<void> setRingMode(RingerModeStatus ringMode) async {
    await SoundMode.setSoundMode(ringMode);
  }

  static Future<RingerModeStatus> getRingMode() async {
    return await SoundMode.ringerModeStatus;
  }
}
