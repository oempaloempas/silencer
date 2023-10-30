import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:silencer/services/auth.dart';
import 'package:silencer/services/location.dart';
import 'package:silencer/services/logging.dart';
import 'package:silencer/services/permissions.dart';
import 'package:silencer/services/soundmode.dart';
import 'package:silencer/services/wifi.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController lat2Controller = TextEditingController();
  TextEditingController lon2Controller = TextEditingController();
  TextEditingController maxRangeController = TextEditingController();

  Future<void> init() async {
    Permissions.ringPermissionGranted();
    Permissions.locationPermissionGranted();
    if (await Soundmode.getRingMode() == RingerModeStatus.normal) {
      silent = false;
      setState(() {});
    }
    bool match = await Wifi.tryFindMatch('AndroidWifi');
    Logging.infoLog(match.toString(), trace: false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  bool silent = true;
  bool? inrange;

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

  String returnRangeText() {
    if (inrange == null) {
      return "";
    }
    if (inrange == true) {
      return "je bent binnen bereik!";
    }
    if (inrange == false) {
      return "je bent buiten bereik";
    }
    return 'error';
  }

  Future<void> logDistance(
    double lat2,
    double lon2,
    double maxrange,
  ) async {
    LocationData location = await LocationService.getLocation();
    bool isInRange = LocationService.inRange(
        location.latitude, location.longitude, lat2, lon2, maxrange);
    Logging.infoLog(isInRange.toString(), trace: false);
    inrange = isInRange;
    setState(() {});
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
          Text(returnRangeText()),
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
            controller: lat2Controller,
            decoration: const InputDecoration(hintText: 'Middelpunt Latitude'),
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
            decoration: const InputDecoration(hintText: 'Middelpunt Longitude'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Geen waarde ingevuld';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: maxRangeController,
            decoration: const InputDecoration(hintText: 'Maximale afstand'),
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
                  double lat2 = double.parse(lat2Controller.text);
                  double lon2 = double.parse(lon2Controller.text);
                  double maxDistance = double.parse(maxRangeController.text);
                  logDistance(lat2, lon2, maxDistance);
                }
              },
              child: const Text('submit'),
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
