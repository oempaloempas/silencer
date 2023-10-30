import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/location.dart';
import 'package:silencer/services/logging.dart';
import 'package:silencer/services/permissions.dart';
import 'package:silencer/services/soundmode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController lat1Controller = TextEditingController();
  TextEditingController lon1Controller = TextEditingController();
  TextEditingController lat2Controller = TextEditingController();
  TextEditingController lon2Controller = TextEditingController();

  Future<void> init() async {
    Permissions.ringPermissionGranted();
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

  Future<void> logDistance(
      double lat1, double lon1, double lat2, double lon2) async {
    Logging.infoLog(
        LocationService.getDistance(lat1, lon1, lat2, lon2, 1).toString());
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
      body: Column(
        children: [
          silenceTest(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          latLonForm(),
        ],
      ),
    );
  }

  Form latLonForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: lat1Controller,
            decoration: const InputDecoration(hintText: 'latitude 1'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geen waarde ingevuld';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: lon1Controller,
            decoration: const InputDecoration(hintText: 'longitude 1'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geen waarde ingevuld';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: lat2Controller,
            decoration: const InputDecoration(hintText: 'latitude 2'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geen waarde ingevuld';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: lon2Controller,
            decoration: const InputDecoration(hintText: 'longitude 2'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geen waarde ingevuld';
              } else {
                return null;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  double lat1 = double.parse(lat1Controller.text);
                  double lon1 = double.parse(lon1Controller.text);
                  double lat2 = double.parse(lat2Controller.text);
                  double lon2 = double.parse(lon2Controller.text);
                }
              },
              child: const Text('Log in'),
            ),
          )
        ],
      ),
    );
  }

  Row silenceTest() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
    ]);
  }
}
