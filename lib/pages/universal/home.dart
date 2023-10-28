import 'package:flutter/material.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/soundmode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> init() async {
    Soundmode.ringPermissionGranted();
    if (await Soundmode.getRingMode() == RingerModeStatus.normal) {
      silent = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  bool silent = true;

  Color returnButtonColor(String buttonName) {
    if (silent) {
      if (buttonName == 'silent') {
        return Colors.green;
      }
    } else {
      if (buttonName == 'sound') {
        return Colors.green;
      }
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('homepage'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Auth().signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
          onPressed: () {
            Soundmode.setRingMode(RingerModeStatus.silent);
            silent = true;
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: returnButtonColor('silent')),
          child: const Text('Enable silent mode'),
        ),
        ElevatedButton(
          onPressed: () {
            Soundmode.setRingMode(RingerModeStatus.normal);
            silent = false;
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: returnButtonColor('sound')),
          child: const Text('Enable sound mode'),
        )
      ]),
    );
  }
}
